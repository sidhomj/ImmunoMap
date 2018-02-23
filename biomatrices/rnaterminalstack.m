function [Mi, Mh] = rnaterminalstack
%RNATERMINALSTACK Free energy contributions for terminal mismatches in RNA
%interior loops and helices
%
% Source: mfold 3.2 
% Temperature: 37C
% Unit: Kcal/mol
% Data arrangement:
%
%  
%                  Y           
%          ------------------  
%      (X)  A    C    G    U   
%          ------------------  
%              5' ==> 3'       
%                x1 X           
%                y1 Y 
%              3' <== 5'       
%      (A)    .  .   .   .
%      (C)    .  .   .   . 
%      (G)    .  .   .   .
%      (U)    .  .   .   .
%
% Mi(X,Y+(y1-1)*4, x1)
% Mh(X,Y+(y1-1)*4, x1)



%--------------------------------------------------------------------------
% INTERNAL LOOPS TERMINAL MISMATCHES
%--------------------------------------------------------------------------

%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          AX                      AX                      AX                      AX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   

nsb=Inf;

Mi = [...
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   0.70  0.70 -0.40  0.70 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.70 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -0.40  0.70  0.70  0.70 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.00 

%  
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          CX                      CX                      CX                      CX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -0.00 -0.00 -1.10 -0.00  nsb   nsb   nsb   nsb
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -0.00 -0.00 -0.00 -0.00  nsb   nsb   nsb   nsb
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -1.10 -0.00 -0.00 -0.00  nsb   nsb   nsb   nsb 
  nsb   nsb   nsb   nsb   nsb   nsb   nsb   nsb  -0.00 -0.00 -0.00 -0.70  nsb   nsb   nsb   nsb


%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          GX                      GX                      GX                      GX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


  nsb   nsb   nsb   nsb  -0.00 -0.00 -1.10 -0.00  nsb   nsb   nsb   nsb   0.70  0.70 -0.40  0.70 
  nsb   nsb   nsb   nsb  -0.00 -0.00 -0.00 -0.00  nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.70 
  nsb   nsb   nsb   nsb  -1.10 -0.00 -0.00 -0.00  nsb   nsb   nsb   nsb  -0.40  0.70  0.70  0.70 
  nsb   nsb   nsb   nsb  -0.00 -0.00 -0.00 -0.70  nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.00 

%  
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          UX                      UX                      UX                      UX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


  0.70  0.70 -0.40  0.70  nsb   nsb   nsb   nsb   0.70  0.70 -0.40  0.70  nsb   nsb   nsb   nsb 
  0.70  0.70  0.70  0.70  nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.70  nsb   nsb   nsb   nsb
 -0.40  0.70  0.70  0.70  nsb   nsb   nsb   nsb  -0.40  0.70  0.70  0.70  nsb   nsb   nsb   nsb 
  0.70  0.70  0.70  0.00  nsb   nsb   nsb   nsb   0.70  0.70  0.70  0.00  nsb   nsb   nsb   nsb];

%--------------------------------------------------------------------------
% HELICES TERMINAL MISMATCHES
%--------------------------------------------------------------------------

%  
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          AX                      AX                      AX                      AX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'

Mh = [...
   nsb  nsb  nsb  nsb      nsb  nsb   nsb   nsb     nsb     nsb     nsb     nsb   -0.30 -0.50 -0.30 -0.30 
   nsb  nsb  nsb  nsb      nsb  nsb   nsb   nsb     nsb     nsb     nsb     nsb   -0.10 -0.20 -1.50 -0.20 
   nsb  nsb  nsb  nsb      nsb  nsb   nsb   nsb     nsb     nsb     nsb     nsb   -1.10 -1.20 -0.20  0.20 
   nsb  nsb  nsb  nsb      nsb  nsb   nsb   nsb     nsb     nsb     nsb     nsb   -0.30 -0.30 -0.60 -1.10 

%  
%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          CX                      CX                      CX                      CX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


   nsb     nsb     nsb     nsb     nsb     nsb     nsb     nsb   -1.50 -1.50 -1.40 -1.80   nsb     nsb     nsb     nsb  
   nsb     nsb     nsb     nsb     nsb     nsb     nsb     nsb   -1.00 -0.90 -2.90 -0.80   nsb     nsb     nsb     nsb 
   nsb     nsb     nsb     nsb     nsb     nsb     nsb     nsb   -2.20 -2.00 -1.60 -1.10   nsb     nsb     nsb     nsb  
   nsb     nsb     nsb     nsb     nsb     nsb     nsb     nsb   -1.70 -1.40 -1.80 -2.00   nsb     nsb     nsb     nsb


%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          GX                      GX                      GX                      GX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


   nsb     nsb     nsb     nsb   -1.10 -1.50 -1.30 -2.10   nsb     nsb     nsb     nsb    0.20 -0.50 -0.30 -0.30 
   nsb     nsb     nsb     nsb   -1.10 -0.70 -2.40 -0.50   nsb     nsb     nsb     nsb   -0.10 -0.20 -1.50 -0.20 
   nsb     nsb     nsb     nsb   -2.40 -2.90 -1.40 -1.20   nsb     nsb     nsb     nsb   -0.90 -1.10 -0.30  0.00 
   nsb     nsb     nsb     nsb   -1.90 -1.00 -2.20 -1.50   nsb     nsb     nsb     nsb   -0.30 -0.30 -0.40 -1.10


%           Y                       Y                       Y                       Y 
%   ------------------      ------------------      ------------------      ------------------   
%    A    C    G    U        A    C    G    U        A    C    G    U        A    C    G    U  
%   ------------------      ------------------      ------------------      ------------------   
%       5' --> 3'               5' --> 3'               5' --> 3'               5' --> 3'     
%          UX                      UX                      UX                      UX 
%          AY                      CY                      GY                      UY 
%       3' <-- 5'               3' <-- 5'               3' <-- 5'               3' <-- 5'   


 -0.50 -0.30 -0.60 -0.50   nsb     nsb     nsb     nsb   -0.50 -0.30 -0.60 -0.50   nsb     nsb     nsb     nsb  
 -0.20 -0.10 -1.20 -0.00   nsb     nsb     nsb     nsb   -0.20 -0.10 -1.70  0.00   nsb     nsb     nsb     nsb 
 -1.40 -1.20 -0.70 -0.20   nsb     nsb     nsb     nsb   -0.80 -1.20 -0.30 -0.70   nsb     nsb     nsb     nsb  
 -0.30 -0.10 -0.50 -0.80   nsb     nsb     nsb     nsb   -0.60 -0.10 -0.60 -0.80   nsb     nsb     nsb     nsb ];
  
