function [internal37, bulge37, hairpin37, tetra, tetraloop37, stack37] = rnafoldenergies
%RNAFOLDENERGIES Free energy contributions for stacking base pairs and generic
% internal loops, bulges and hairpins up to size 30 nt.
%
% Source: mfold 3.2 
% Temperature: 37C
% Unit: Kcal/mol

%--------------------------------------------------------------------------
% INTERNAL, BULGES, HAIRPINS
%--------------------------------------------------------------------------


data37 = [...
% SIZE         INTERNAL            BULGE            HAIRPIN 
% ------------------------------------------------------- 
1               Inf               3.80              Inf  ;
2               Inf               2.80              Inf  ;
3               Inf               3.20              5.70 ; 
4              1.70               3.60              5.60 ;
5              1.80               4.00              5.60 ;
6              2.00               4.40              5.40 ;
7              2.20               4.60              5.90 ;
8              2.30               4.70              5.60 ;
9              2.40               4.80              6.40 ;
10             2.50               4.90              6.50 ;
11             2.60               5.00              6.60 ;
12             2.70               5.10              6.70 ;
13             2.80               5.20              6.80 ;
14             2.90               5.30              6.90 ;
15             3.00               5.40              6.90 ;
16             3.00               5.40              7.00 ;
17             3.10               5.50              7.10 ;
18             3.10               5.50              7.10 ;
19             3.20               5.60              7.20 ;
20             3.30               5.70              7.20 ;
21             3.30               5.70              7.30 ;
22             3.40               5.80              7.30 ;
23             3.40               5.80              7.40 ;
24             3.40               5.80              7.40 ;
25             3.50               5.90              7.50 ;
26             3.50               5.90              7.50 ;
27             3.60               6.00              7.50 ;
28             3.60               6.00              7.60 ;
29             3.60               6.00              7.60 ;
30             3.70               6.10              7.70 ;
];

internal37(:,1)=data37(:,2);
bulge37(:,1)=data37(:,3);
hairpin37(:,1)=data37(:,4);

%--------------------------------------------------------------------------
% BASE-PAIR STACKING ENERGIES
%--------------------------------------------------------------------------

% stack37(X + (x1-1)*4, Y + (y1-1)*4)
%                  Y           
%          ------------------  
%      (X)  A    C    G    U   
%          ------------------  
%              5' ==> 3'        
%                 x1 X            
%                 y1 Y 
%              3' <== 5'       
%      (A)   .     .     .     .   
%      (C)   .     .     .     .   
%      (G)   .     .     .     .   
%      (U)   .     .     .     .
%  
% 

nsb=Inf;

%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          AX                      AX                      AX                      AX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   

stack37 = [...
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -0.90 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.20  nsb  
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.10  nsb  -0.60 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -1.10  nsb  -1.40  nsb   
 
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          CX                      CX                      CX                      CX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.10  nsb   nsb   nsb   nsb  
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -3.30  nsb   nsb   nsb   nsb   nsb   
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.40  nsb  -1.40  nsb   nsb   nsb   nsb  
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.10  nsb  -2.10  nsb   nsb   nsb   nsb   nsb 

%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          GX                      GX                      GX                      GX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


  nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.40  nsb   nsb   nsb   nsb   nsb   nsb   nsb  -1.30 
  nsb   nsb   nsb   nsb   nsb   nsb  -3.40  nsb   nsb   nsb   nsb   nsb   nsb   nsb  -2.50  nsb  
  nsb   nsb   nsb   nsb   nsb  -3.30  nsb  -1.50  nsb   nsb   nsb   nsb   nsb  -2.10  nsb  -0.50  
  nsb   nsb   nsb   nsb  -2.20  nsb  -2.50  nsb   nsb   nsb   nsb   nsb  -1.40  nsb   1.30  nsb   
 
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          UX                      UX                      UX                      UX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   

  nsb   nsb   nsb  -1.30  nsb   nsb   nsb   nsb   nsb   nsb   nsb  -1.00  nsb   nsb   nsb   nsb  
  nsb   nsb  -2.40  nsb   nsb   nsb   nsb   nsb   nsb   nsb  -1.50  nsb   nsb   nsb   nsb   nsb   
  nsb  -2.10  nsb  -1.00  nsb   nsb   nsb   nsb   nsb  -1.40  nsb   0.30  nsb   nsb   nsb   nsb  
 -0.90  nsb  -1.30  nsb   nsb   nsb   nsb   nsb  -0.60  nsb  -0.50  nsb   nsb   nsb   nsb   nsb   ];


%--------------------------------------------------------------------------
% TETRALOOPS
%--------------------------------------------------------------------------
%  'GGGGAC' -3.00;
%  'GGUGAC' -3.00; 
%  'CGAAAG' -3.00; 
%  'GGAGAC' -3.00; 
%  'CGCAAG' -3.00; 
%  'GGAAAC' -3.00; 
%  'CGGAAG' -3.00; 
%  'CUUCGG' -3.00; 
%  'CGUGAG' -3.00; 
%  'CGAAGG' -2.50; 
%  'CUACGG' -2.50; 
%  'GGCAAC' -2.50; 
%  'CGCGAG' -2.50; 
%  'UGAGAG' -2.50; 
%  'CGAGAG' -2.00; 
%  'AGAAAU' -2.00; 
%  'CGUAAG' -2.00; 
%  'CUAACG' -2.00; 
%  'UGAAAG' -2.00; 
%  'GGAAGC' -1.50; 
%  'GGGAAC' -1.50; 
%  'UGAAAA' -1.50; 
%  'AGCAAU' -1.50; 
%  'AGUAAU' -1.50; 
%  'CGGGAG' -1.50; 
%  'AGUGAU' -1.50; 
%  'GGCGAC' -1.50; 
%  'GGGAGC' -1.50; 
%  'GUGAAC' -1.50; 
%  'UGGAAA' -1.50;

 tetra=[ ...
 'GGGGAC' 
 'GGUGAC'
 'CGAAAG'
 'GGAGAC'
 'CGCAAG' 
 'GGAAAC'  
 'CGGAAG' 
 'CUUCGG'
 'CGUGAG'
 'CGAAGG'
 'CUACGG' 
 'GGCAAC' 
 'CGCGAG' 
 'UGAGAG' 
 'CGAGAG'
 'AGAAAU' 
 'CGUAAG' 
 'CUAACG' 
 'UGAAAG'
 'GGAAGC' 
 'GGGAAC' 
 'UGAAAA'
 'AGCAAU'
 'AGUAAU' 
 'CGGGAG' 
 'AGUGAU' 
 'GGCGAC'
 'GGGAGC' 
 'GUGAAC' 
 'UGGAAA'];

tetraloop37=[...
 -3.00;
 -3.00; 
 -3.00; 
 -3.00; 
 -3.00; 
 -3.00; 
 -3.00; 
 -3.00; 
 -3.00; 
 -2.50; 
 -2.50; 
 -2.50; 
 -2.50; 
 -2.50; 
 -2.00; 
 -2.00; 
 -2.00; 
 -2.00; 
 -2.00; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50; 
 -1.50;
 ];
