function Data = ImmunoMap_Core(Input,ScoringMatrix,GapPen,threshold,clusterthreshold);

% FreqCut=0.0001;
% ResponseCut=.25;
% ReadCut=10;
% TopSeq=2;
% ScoringMatrix='PAM10';
% GapPen=30;
% threshold=0.35;
% clusterthreshold=0.03;
PreExpansion=0.1;
Greedy=0;

% Input.fileread=fileread1;
% Input.ResponseCut=ResponseCut;
Output=ParseAdaptiveFile(Input);

for i=1:size(Output.AA,1);
    Seq(i).Header=char(Output.AA(i));
    Seq(i).Sequence=char(Output.AA(i));
end

Data.UniqueCDR3=size(Seq,2);

Freq=cell2mat(Output.Freq);
Reads=cell2mat(Output.Reads);

Data.ShannonEntropy=-sum(Freq.*log(Freq));

if Greedy==1;
    [Seq,Freq,Reads]=GreedyCluster(Seq,Reads,Freq,ScoringMatrix,GapPen);
    clear Output
    for i=1:size(Seq,2);
        Output.AA(i)={Seq(i).Sequence};
    end

    Output.AA=transpose(Output.AA);
end


if size(Seq,2)==1;
    Motif.Seq=Seq;
    Motif.FreqInd=Freq;
    Motif.FreqSum=Freq;
    Data.TotalMotifs=1;
    Data.TotalRichness=1;
    Data.TotalSEI=0;
elseif size(Seq,2)==2;
    DistanceMatrix=DistanceFunction(Seq(1).Sequence,Seq(2).Sequence,ScoringMatrix,GapPen);
    
    if DistanceMatrix>=threshold
        Motif(1).Seq=Seq(1).Sequence;
        Motif(2).Seq=Seq(2).Sequence;
        Motif(1).FreqInd=Freq(1);
        Motif(2).FreqInd=Freq(2);
        Motif(1).FreqSum=Freq(1);
        Motif(2).FreqSum=Freq(2);
    else
        Motif.Seq=Seq;
        Motif.FreqInd=Freq;
        Motif.FreqSum=sum(Freq);
    end
    
    Data.TotalMotifs=size(Motif,2);
    Data.TotalRichness=2/size(Motif,2);
    FreqAllRel=Freq./sum(Freq);
    Data.TotalSEI=(-sum(FreqAllRel.*log(FreqAllRel)))./log(size(FreqAllRel,1));
    DistanceMatrix=[0 DistanceMatrix];
    
else
       
    ScoringMatrix=feval(lower(ScoringMatrix));
    tic
    for i=1:size(Seq,2);
        Score1(i)=nwalign(Seq(i).Sequence,Seq(i).Sequence,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
    end
    Score2=transpose(Score1);
    Score1=repmat(Score1,size(Score1,2),1);
    n=1;
    for i=1:size(Score1,1)-1;
        for j=i+1:size(Score1,1);
            Score1D(n)=Score1(i,j);
            n=n+1;
        end
    end
    
    Score2=repmat(Score2,1,size(Score2,1));
    
    n=1;
    for i=1:size(Score2,1)-1;
        for j=i+1:size(Score2,1);
            Score2D(n)=Score2(i,j);
            n=n+1;
        end
    end
    
    NumSeqT=size(Seq,2);
    SizeMatrix=NumSeqT*(NumSeqT-1)/2;
    
    n=1;
    for i=1:size(Seq,2)-1;
        for j=i+1:size(Seq,2);
            Seq1(n)=i;
            Seq2(n)=j;
            n=n+1;
        end
    end
    
   
    parfor i=1:SizeMatrix;
        DCheck(i)=nwalign(Seq(Seq1(i)).Sequence,Seq(Seq2(i)).Sequence,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
    end
    
    
    DistanceVector=(1-DCheck./Score1D).*(1-DCheck./Score2D);
    
%     for n=1:size(DistanceVector,2);
%         DistanceMatrix(Seq1(n),Seq2(n))=DistanceVector(n);
%     end
%     
    DistanceMatrix=squareform(DistanceVector);
    DistanceMatrix=triu(DistanceMatrix,1);
    DistanceMatrix=DistanceMatrix(1:end-1,:);
    
    toc
    
    Tree=linkage(DistanceVector,'average');
    C=cluster(Tree,'cutoff',threshold,'criterion','distance');
    clustercount=size(unique(C),1);
    
    Clusters=ClusterReturn(clustercount,Tree,C,Output.AA);
    
    for i=1:size(Clusters,2);
        freqcluster=0;
        for j=1:size(Clusters(i).Seq,2)
            seqtemp=char(Clusters(i).Seq(j));
            x=strmatch(seqtemp,Output.AA,'exact');
            freqseq=Freq(x);
            Clusters(i).FreqInd(j,:)=freqseq;
            freqcluster=freqcluster+freqseq;          
        end
        Clusters(i).FreqSum=freqcluster;
    end
    
    Data.TotalMotifs=clustercount;
    Data.TotalRichness=size(Seq,2)/clustercount;
    
    for i=1:size(Clusters,2);
        FreqAll(i)=Clusters(i).FreqSum;
    end
    
    FreqAllRel=FreqAll./sum(FreqAll);
    Data.TotalSEI=(-sum(FreqAllRel.*log(FreqAllRel)))./log(size(FreqAllRel,2));
    
    
    countfinal=0;
    for i=1:size(Clusters,2);
        freqcheck=Clusters(i).FreqSum;
        if freqcheck>=clusterthreshold
            countfinal=countfinal+1;
            sequences=Clusters(i).Seq;
            Motif(countfinal).seq=Clusters(i).Seq;
            Motif(countfinal).FreqInd=Clusters(i).FreqInd;
            Motif(countfinal).FreqSum=Clusters(i).FreqSum;
        end
    end
end

    if exist('Motif');
        SeqCount=0;
        for i=1:size(Motif,2);
            SeqCount=SeqCount+size(Motif(i).FreqInd,1);
        end
        
        Data.NumberOfMotifs=size(Motif,2);
        Data.Richness=SeqCount/Data.NumberOfMotifs;
        
        
        for i=1:size(Motif,2);
            FreqRel=Motif(i).FreqInd./(sum(Motif(i).FreqInd));
            SE=FreqRel.*log(FreqRel);
            SE=-sum(SE);
            Motif(i).SEI=SE/log(size(FreqRel,1));
            if isnan(Motif(i).SEI)
                Motif(i).SEI=0;
            end
            SEIMatrix(i)=Motif(i).SEI;
        end
        Data.Motifs=Motif;
        Data.SEI=mean(SEIMatrix);
        
            
    else
        Data.NumberOfMotifs=0;
        Data.Richness=0;
        Data.SEI=0;
    end

%%%Calculate TCRDiversity Score & Singular Clones

if size(Seq,2)==1
    Data.SingularClones=100;
    Data.SingularContrib=100*Freq;
    Data.TCRDiversityScore=0;
else
    
    DistanceMatrix2=[DistanceMatrix;zeros(1,size(DistanceMatrix,2))];
    DistanceMatrix3=1./(1+DistanceMatrix2);
    DistanceMatrix3=triu(DistanceMatrix3);
    HomologyThresh=DistanceMatrix2<threshold;
    HomologyThresh=triu(HomologyThresh,1);
    FreqSimilar=transpose(Freq)*HomologyThresh;
    SingularClonesIndex=1-((FreqSimilar./transpose(Freq))>=PreExpansion);
    NumSingularClones=sum(SingularClonesIndex);
    Data.SingularClones=100*(NumSingularClones/size(Freq,1));
    Data.SingularContrib=100*(sum(SingularClonesIndex.*transpose(Freq)));
   
    for i=1:size(DistanceMatrix3,1);
        for j=1:size(DistanceMatrix3,2);
            if i==j
                if Reads(i)==1
                    ScorePreOut(i,j)=0;
                else
                    ScorePreOut(i,j)=DistanceMatrix3(i,j)*combntns(Reads(i),2);
                end
            else
                ScorePreOut(i,j)=DistanceMatrix3(i,j)*Reads(i)*Reads(j);
            end
        end
    end

    Data.TCRDiversityScore=1-(sum(sum(ScorePreOut))/combntns(sum(Reads),2));
end

try
    [~,index] = sortrows([Data.Motifs.FreqSum].'); Data.Motifs = Data.Motifs(index(end:-1:1)); clear index
catch

end

end

function Output=ParseFile(Input);

fileread=Input.fileread;

if isfield(Input,'FreqCut');
    freqcut=Input.FreqCut;
elseif isfield(Input,'ResponseCut');
    freqcut2=Input.ResponseCut;
elseif isfield(Input,'TopSeq');
    TopSeq=Input.TopSeq;
elseif isfield(Input,'ReadCut');
    ReadCut=Input.ReadCut;
end
    
if isequal(fileread(end-2:end),'tsv')
    
    fid=fopen(fileread);
    header=textscan(fid,repmat('%s',1,52),1,'delimiter','\t');
    data=textscan(fid,repmat('%s',1,52),'delimiter','\t');

    for i=1:size(data,2);
        if i==3 || i==4 || i==5
            data2(:,i)=num2cell(cellfun(@str2num,data{1,i}));
        else
        data2(:,i)=data{1,i};
        end
    end

    DataTable=table(data2);
    DataTable = [table(DataTable.data2(:,1),'VariableNames',{'data21'}),table(DataTable.data2(:,2),'VariableNames',{'data22'}),table(DataTable.data2(:,3),'VariableNames',{'data23'}),table(DataTable.data2(:,4),'VariableNames',{'data24'}),table(DataTable.data2(:,5),'VariableNames',{'data25'}),table(DataTable.data2(:,6),'VariableNames',{'data26'}),table(DataTable.data2(:,7),'VariableNames',{'data27'}),table(DataTable.data2(:,8),'VariableNames',{'data28'}),table(DataTable.data2(:,9),'VariableNames',{'data29'}),table(DataTable.data2(:,10),'VariableNames',{'data210'}),table(DataTable.data2(:,11),'VariableNames',{'data211'}),table(DataTable.data2(:,12),'VariableNames',{'data212'}),table(DataTable.data2(:,13),'VariableNames',{'data213'}),table(DataTable.data2(:,14),'VariableNames',{'data214'}),table(DataTable.data2(:,15),'VariableNames',{'data215'}),table(DataTable.data2(:,16),'VariableNames',{'data216'}),table(DataTable.data2(:,17),'VariableNames',{'data217'}),table(DataTable.data2(:,18),'VariableNames',{'data218'}),table(DataTable.data2(:,19),'VariableNames',{'data219'}),table(DataTable.data2(:,20),'VariableNames',{'data220'}),table(DataTable.data2(:,21),'VariableNames',{'data221'}),table(DataTable.data2(:,22),'VariableNames',{'data222'}),table(DataTable.data2(:,23),'VariableNames',{'data223'}),table(DataTable.data2(:,24),'VariableNames',{'data224'}),table(DataTable.data2(:,25),'VariableNames',{'data225'}),table(DataTable.data2(:,26),'VariableNames',{'data226'}),table(DataTable.data2(:,27),'VariableNames',{'data227'}),table(DataTable.data2(:,28),'VariableNames',{'data228'}),table(DataTable.data2(:,29),'VariableNames',{'data229'}),table(DataTable.data2(:,30),'VariableNames',{'data230'}),table(DataTable.data2(:,31),'VariableNames',{'data231'}),table(DataTable.data2(:,32),'VariableNames',{'data232'}),table(DataTable.data2(:,33),'VariableNames',{'data233'}),table(DataTable.data2(:,34),'VariableNames',{'data234'}),table(DataTable.data2(:,35),'VariableNames',{'data235'}),table(DataTable.data2(:,36),'VariableNames',{'data236'}),table(DataTable.data2(:,37),'VariableNames',{'data237'}),table(DataTable.data2(:,38),'VariableNames',{'data238'}),table(DataTable.data2(:,39),'VariableNames',{'data239'}),table(DataTable.data2(:,40),'VariableNames',{'data240'}),table(DataTable.data2(:,41),'VariableNames',{'data241'}),table(DataTable.data2(:,42),'VariableNames',{'data242'}),table(DataTable.data2(:,43),'VariableNames',{'data243'}),table(DataTable.data2(:,44),'VariableNames',{'data244'}),table(DataTable.data2(:,45),'VariableNames',{'data245'}),table(DataTable.data2(:,46),'VariableNames',{'data246'}),table(DataTable.data2(:,47),'VariableNames',{'data247'}),table(DataTable.data2(:,48),'VariableNames',{'data248'}),table(DataTable.data2(:,49),'VariableNames',{'data249'}),table(DataTable.data2(:,50),'VariableNames',{'data250'}),table(DataTable.data2(:,51),'VariableNames',{'data251'}),table(DataTable.data2(:,52),'VariableNames',{'data252'})];
    DataTable=sortrows(DataTable,-3);
    DataTable=table2cell(DataTable);

    n=1;
    for i=1:size(DataTable,1);
        seqtemp=DataTable{i,2};
        if isempty(seqtemp) || contains(seqtemp,'*')
        else
            sel(n)=i;
            n=n+1;
        end
    end

    DataFinal=DataTable(sel,:);
    raw=[header;DataFinal];
    
else
    

    [num,txt,raw]=xlsread(fileread);
    
        tic
    for i=1:size(raw,1)
        for j=1:size(raw,2)
            if isnan(cell2mat(raw(i,j)))
                raw(i,j)={'Unresolved'};
            end
        end
    end
    toc

end





selection=2:size(raw,1);

n=1;

%% Use following for Custom-made files
% for i=selection
%     AA(n)=raw(i,2);
%     Reads(n)=raw(i,3);
%     CDR3(n)=raw(i,4);
%     Vbeta(n)=raw(i,5);
%     Dbeta(n)=raw(i,6);
%     Jbeta(n)=raw(i,7);
%     n=n+1;
% end


%% Use following for Adaptive Files

for i=selection
    AA(n)=raw(i,2);
    Reads(n)=raw(i,3);
    CDR3(n)=raw(i,5);
    Vbeta(n)=raw(i,6);
    Dbeta(n)=raw(i,13);
    Jbeta(n)=raw(i,20);
    n=n+1;
end

%% Use following for Luznick Files
% for i=selection
%     AA(n)=raw(i,2);
%     Reads(n)=raw(i,5);
%     CDR3(n)=raw(i,9);
%     Vbeta(n)=raw(i,10);
%     Dbeta(n)=raw(i,13);
%     Jbeta(n)=raw(i,16);
%     n=n+1;
% end

%%Use for Manafest Output;

% for i=selection
%     AA(n)=raw(i,1);
%     Reads(n)=raw(i,2);
%     n=n+1;
% end

%%

AAUnique=unique(AA);

Readsum=sum(cellfun(@sum,Reads));
Freq=cell2mat(Reads)./Readsum;
freqsum=sum(Freq);
Freq=num2cell(Freq);

conc=1;

if conc

    parfor i=1:size(AAUnique,2)
        seqtemp=AAUnique(i);
        x=strmatch(char(seqtemp),AA,'exact');
        FreqNet=0;
        ReadNet=0;
        for j=1:size(x,1)
            FreqNet=FreqNet+double(cell2mat(Freq(x(j))));
            ReadNet=ReadNet+double(cell2mat(Reads(x(j))));
        end
        FreqOut(i)=FreqNet;
        ReadOut(i)=ReadNet;
    end

    T=[transpose(AAUnique),transpose(num2cell(ReadOut)),transpose(num2cell(FreqOut))];
    T=table(T);
    T = [table(T.T(:,1),'VariableNames',{'T1'}),table(T.T(:,2),'VariableNames',{'T2'}),table(T.T(:,3),'VariableNames',{'T3'})];
    T=sortrows(T,-2);
    T=table2cell(T);

    AA=T(:,1);
    Reads=T(:,2);
    Freq=T(:,3);
else
    AA=transpose(AA);
    Reads=transpose(Reads);
    Freq=transpose(Freq);

end

cut=size(Freq,1);

if exist('freqcut');

for i=1:size(Freq,1)
    if cell2mat(Freq(i))<freqcut;
        cut=i-1;
        break
    end
end

elseif exist('freqcut2');
    
FreqCurrentSum=0;
for i=1:size(Freq,1)
    FreqCurrentSum=FreqCurrentSum+cell2mat(Freq(i));
    if FreqCurrentSum >= freqcut2;
        cut2=i;
        break
    end
end

% 
if exist('cut2')
    cut=cut2;
end

elseif exist('TopSeq');
    cut=TopSeq;  
elseif exist('ReadCut');
    for i=1:size(Reads,1)
        if cell2mat(Reads(i))<ReadCut;
            cut=i-1;
            break
        end
    end
end

AA=AA(1:cut);
Freq=Freq(1:cut);
Reads=Reads(1:cut);


Output.AA=AA;
Output.Freq=Freq;
Output.Reads=Reads;




end

function Distance=DistanceFunction(seq1,seq2,ScoringMatrix,GapPen);

Score11=nwalign(seq1,seq1,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
Score22=nwalign(seq2,seq2,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
Score12=nwalign(seq1,seq2,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);

Distance=(1-(Score12/Score11))*(1-(Score12/Score22));


end

function DistanceVector=ConvertMatrixForTree(DistanceMatrix);

    id=1;
    for indext=1:size(DistanceMatrix,1);
        for indext2=indext+1:size(DistanceMatrix,2);
                DistanceVector(id)=DistanceMatrix(indext,indext2);
                id=id+1;
        end
    end

end

function Clusters=ClusterReturn(clustercount,Tree,C,Seq);

for i=1:clustercount
    selection=C==i;
    n=1;
    for j=1:size(selection,1);
        if selection(j)==1
            SeqCluster(i).Seq(n)=Seq(j);
            n=n+1;
        end
    end
end

Clusters=SeqCluster;

end






