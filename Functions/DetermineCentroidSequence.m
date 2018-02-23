function [SeqC,Index]=DetermineCentroidSequence(seq,ScoringMatrix,GapPen);

Data=DistanceVector2Seq(seq,seq,ScoringMatrix,GapPen);
DistClust=Data.DistanceMatrix;

 for y=1:size(DistClust,1);
    DistClust2=DistClust(y,:);
    DistSeq(y)=median(DistClust2(DistClust2>0));
 end

[Minim,Index]=min(DistSeq);

SeqC=seq{Index};


end