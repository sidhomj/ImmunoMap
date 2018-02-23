function Data= DistanceVector2Seq(Seq1,Seq2,ScoringMatrix,GapPen);

        ScoringMatrix=feval(lower(ScoringMatrix));
        for i=1:size(Seq1,2);
            Score1(i)=nwalign(Seq1{i},Seq1{i},'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
        end
        
        Score1=repmat(Score1,size(Seq2,2),1);
        
        n=1;
        for i=1:size(Score1,1);
            for j=1:size(Score1,2);
                Score1D(n)=Score1(i,j);
                n=n+1;
            end
        end
        
        for i=1:size(Seq2,2);
            Score2(i)=nwalign(Seq2{i},Seq2{i},'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
        end
        
        Score2=repmat(transpose(Score2),1,size(Seq1,2));
        
        n=1;
        for i=1:size(Score2,1);
            for j=1:size(Score2,2);
                Score2D(n)=Score2(i,j);
                n=n+1;
            end
        end
        
        n=1;
        for i=1:size(Seq2,2);
            for j=1:size(Seq1,2);
                Seq2C(n)=i;
                Seq1C(n)=j;
                n=n+1;
            end
        end
        
        parfor u=1:size(Seq1C,2);
            DCheck(u)=nwalign(Seq1(Seq1C(u)),Seq2(Seq2C(u)),'ScoringMatrix',ScoringMatrix,'GapOpen',GapPen);
        end
        
        
        DistanceVector=(1-DCheck./Score1D).*(1-DCheck./Score2D);
        Data.DistanceVector=DistanceVector;
         for n=1:size(DistanceVector,2);
            DistanceMatrix(Seq1C(n),Seq2C(n))=DistanceVector(n);
         end
         
         Data.DistanceMatrix=DistanceMatrix;

end
