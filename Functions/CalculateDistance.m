function DistanceVector=CalculateDistance(Seq,ScoringMatrix,GapPen);
%Calculates Distance Vector for all pairwise alignments given formula for
%sequence distance provided in manuscript. 

    for i=1:size(Seq,2);
        Score1(i)=nwalign(Seq(i).Sequence,Seq(i).Sequence,'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
        %Score1(i)=swalign(char(Seq(i).Sequence),char(Seq(i).Sequence),'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
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
        %DCheck(i)=swalign(char(Seq(Seq1(i)).Sequence),char(Seq(Seq2(i)).Sequence),'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);

    end
    
    
    DistanceVector=(1-DCheck./Score1D).*(1-DCheck./Score2D);
    
