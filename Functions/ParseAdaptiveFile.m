function Output=ParseAdaptiveFile(Input);

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
       
    fid=fopen(fileread);
    header=textscan(fgetl(fid),'%s','Delimiter','\t')';
    header=transpose(header{1});
    numcol=size(header,2);
    data=textscan(fid,repmat('%s',1,numcol),'delimiter','\t');
    data2 = cell(size(data{1},1),3);
    for i=1:3
        data2(:,i)=data{1,i};   
    end
    data=data2;
    clear data2;
    data(:,3)=num2cell(cellfun(@str2num,data(:,3)));
    data=sortrows(data,-3);
    data=data(~cellfun(@(x) isempty(x) || contains(x,'*'), data(:,2)),:);
    
    raw=[header(1:3);data];​
    
AA=raw(2:end,2);
Reads=raw(2:end,3);


Readsum=sum(cellfun(@sum,Reads));
Freq=cell2mat(Reads)./Readsum;
freqsum=sum(Freq);
Freq=num2cell(Freq);

concpre=1;

if concpre
   [AA,Reads,Freq]=ConcatenateTCR(AA,Reads,Freq);
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

Output.ReadSum=sum(cell2mat(Reads));
AA=AA(1:cut);
Freq=Freq(1:cut);
Reads=Reads(1:cut);

concpost=0;

if concpost==1
    [AA,Reads,Freq]=ConcatenateTCR(AA,Reads,Freq);
end


Output.AA=AA;
Output.Freq=Freq;
Output.Reads=Reads;


end

function [AA,Reads,Freq]=ConcatenateTCR(AA,Reads,Freq)   
    AAUnique=unique(AA);
    parfor i=1:size(AAUnique,1)
        seqtemp=AAUnique(i);
        x=strmatch(char(seqtemp),AA,'exact');
        FreqOut(i)=sum(cell2mat(Freq(x)));
        ReadOut(i)=sum(cell2mat(Reads(x)));
    end
    [B,I]=sort(ReadOut,'descend');
    AA=AAUnique(I);
    Reads=num2cell(transpose(B));
    Freq=num2cell(transpose(FreqOut(I)));   

end