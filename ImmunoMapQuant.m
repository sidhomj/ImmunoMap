function varargout = ImmunoMapQuant(varargin)
% IMMUNOMAPQUANT MATLAB code for ImmunoMapQuant.fig
%      IMMUNOMAPQUANT, by itself, creates a new IMMUNOMAPQUANT or raises the existing
%      singleton*.
%
%      H = IMMUNOMAPQUANT returns the handle to a new IMMUNOMAPQUANT or the handle to
%      the existing singleton*.
%
%      IMMUNOMAPQUANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMMUNOMAPQUANT.M with the given input arguments.
%
%      IMMUNOMAPQUANT('Property','Value',...) creates a new IMMUNOMAPQUANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImmunoMapQuant_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImmunoMapQuant_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImmunoMapQuant

% Last Modified by GUIDE v2.5 01-Sep-2017 13:19:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImmunoMapQuant_OpeningFcn, ...
                   'gui_OutputFcn',  @ImmunoMapQuant_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ImmunoMapQuant is made visible.
function ImmunoMapQuant_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImmunoMapQuant (see VARARGIN)
matlabImage = imread('logo.png'); %%Sets image of logo to top of GUI
image(matlabImage)
axis off
axis image
addpath('Functions/');
% Choose default command line output for ImmunoMapQuant
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImmunoMapQuant wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImmunoMapQuant_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_files.
function select_files_Callback(hObject, eventdata, handles)
% hObject    handle to select_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% gets *tsv files created by Adaptive Biotechnologies ImmunoSeq Portal
[filename,folder]=uigetfile({'*.tsv'},'Select file','MultiSelect','on');
filename2=fullfile(folder,filename);
handles.files.String=filename;
handles.files.Value=[]
handles.sample1sel.String=filename;
handles.sample2sel.String=filename;
handles.fileref=filename2;
guidata(hObject,handles);



% --- Executes on selection change in files.
function files_Callback(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from files


% --- Executes during object creation, after setting all properties.
function files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in thresh_type.
function thresh_type_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns thresh_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from thresh_type


% --- Executes during object creation, after setting all properties.
function thresh_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function threshtypeval_Callback(hObject, eventdata, handles)
% hObject    handle to threshtypeval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshtypeval as text
%        str2double(get(hObject,'String')) returns contents of threshtypeval as a double


% --- Executes during object creation, after setting all properties.
function threshtypeval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshtypeval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold as text
%        str2double(get(hObject,'String')) returns contents of threshold as a double


% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clusterthreshold_Callback(hObject, eventdata, handles)
% hObject    handle to clusterthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clusterthreshold as text
%        str2double(get(hObject,'String')) returns contents of clusterthreshold as a double


% --- Executes during object creation, after setting all properties.
function clusterthreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clusterthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scoringmatrix.
function scoringmatrix_Callback(hObject, eventdata, handles)
% hObject    handle to scoringmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scoringmatrix contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scoringmatrix


% --- Executes during object creation, after setting all properties.
function scoringmatrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoringmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GapPen_Callback(hObject, eventdata, handles)
% hObject    handle to GapPen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GapPen as text
%        str2double(get(hObject,'String')) returns contents of GapPen as a double


% --- Executes during object creation, after setting all properties.
function GapPen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GapPen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Checks that user has selected files before proceeding with analysis
if isempty(handles.files.Value);
    hbox1=msgbox('No files selected','Error','error');
    return
end

%%Collects the type of threshold the user wants to use
types={'FreqCut','ResponseCut','TopSeq','ReadCut'};
type=types{handles.thresh_type.Value};
ScoringMatrix=handles.scoringmatrix.String{handles.scoringmatrix.Value};
GapPen=str2num(handles.GapPen.String);
threshold=str2num(handles.threshold.String);
clusterthreshold=str2num(handles.clusterthreshold.String)/100;

switch handles.thresh_type.Value
    case 1
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 2
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 3
        filecutparam=str2num(handles.threshtypeval.String);
    case 4
        filecutparam=str2num(handles.threshtypeval.String);
end

%%Main Loop running the ImmunoMap algorithm on the selected files for
%%analysis 
    
h = waitbar(0,'Please wait...');
for i=1:size(handles.files.Value,2)
    if size(handles.files.String,1)==1
        Input.fileread=handles.fileref;
        AnalyzeList{i}=handles.files.String;
    else
        Input.fileread=handles.fileref{handles.files.Value(i)};
        AnalyzeList{i}=handles.files.String{handles.files.Value(i)};
    end
    eval(['Input.' type '=filecutparam;'])
    Data(i).DataInd=ImmunoMap_Core(Input,ScoringMatrix,GapPen,threshold,clusterthreshold) 
    waitbar(i/size(handles.files.Value,2));
end
close(h);

%%resets parameters in cluster selection listbox if this analysis has been
%%carried out before
handles.motiflooksel.Value=[1];
handles.motiflooksel.String=AnalyzeList;

%%looping through data collecting relevant ImmunoMap parameters and updates
%%the dialogue box showing a table of these parameters
for i=1:size(Data,2)
    if size(handles.files.String,1)==1
        DataCell{i,1}=handles.files.String;
    else
        DataCell{i,1}=handles.files.String{handles.files.Value(i)};
    end
    DataCell{i,2}=Data(i).DataInd.UniqueCDR3;
    DataCell{i,3}=Data(i).DataInd.ShannonEntropy;
    DataCell{i,4}=Data(i).DataInd.NumberOfMotifs;
    DataCell{i,5}=Data(i).DataInd.Richness;
    DataCell{i,6}=Data(i).DataInd.SingularClones;
    DataCell{i,7}=Data(i).DataInd.SingularContrib;
    DataCell{i,8}=Data(i).DataInd.TCRDiversityScore;
end

ColumnNames={'Filename','# of Unique CDR3','Shannon Entropy','Number Of Motifs','Richness of Motifs','Singular Clones (% of Seq)','Contribution of Singular Clones (% of Response)','TCR Diversity Score'};
handles.IM_metrics.ColumnName=ColumnNames
handles.IM_metrics.Data=DataCell;
handles.Data=Data;

guidata(hObject,handles);
motiflooksel_Callback(hObject, eventdata, handles)



% --- Executes on button press in lookDM.
function lookDM_Callback(hObject, eventdata, handles)
% hObject    handle to lookDM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%This segment of code allows the user to look at the multiple alignments
%%of a single Dominant Motif

dataex=handles.Data(handles.motiflooksel.Value).DataInd.Motifs;

for i=handles.DM_list.Value
    if size(dataex(i).seq,2)>2
        showalignment(multialign(dataex(i).seq));
    elseif size(dataex(i).seq,2)==2
        [score,alignment]=nwalign(dataex(i).seq{1},dataex(i).seq{2},'ScoringMatrix',handles.scoringmatrix.String{handles.scoringmatrix.Value},'GapOpen',str2num(handles.GapPen.String));
        showalignment(alignment)
    else
        msgbox(dataex(i).seq)
    end
end


% --- Executes on selection change in motiflooksel.
function motiflooksel_Callback(hObject, eventdata, handles)
% hObject    handle to motiflooksel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns motiflooksel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from motiflooksel

    %%This segment of the code updates the list of Clusters in terms of
    %%their identifier as well as the contribution to the response they
    %%make
    try
        dataex=handles.Data(handles.motiflooksel.Value).DataInd.Motifs;

        for i=1:size(dataex,2)
            Cluster_List(i)=strcat({'Motif '},num2str(i),{' - '},num2str(dataex(i).FreqSum*100),'%');
        end

        handles.DM_list.Value=[];
        handles.DM_list.String=Cluster_List;
    catch
        handles.DM_list.Value=[];
        handles.DM_list.String={};
end



% --- Executes during object creation, after setting all properties.
function motiflooksel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motiflooksel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DM_list.
function DM_list_Callback(hObject, eventdata, handles)
% hObject    handle to DM_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DM_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DM_list


% --- Executes during object creation, after setting all properties.
function DM_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DM_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savetable.
function savetable_Callback(hObject, eventdata, handles)
% hObject    handle to savetable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tablewrite=[transpose(handles.IM_metrics.ColumnName);handles.IM_metrics.Data];
[FileName,PathName] = uiputfile({'*.csv'});
FileName2=fullfile(PathName,FileName);
cell2csv(FileName2,tablewrite);


% --- Executes on button press in dendro.
function dendro_Callback(hObject, eventdata, handles)
% hObject    handle to dendro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Creates Weighted Repertoire Dendrograms of Repertoires

load('ColorsSegments.mat')
types={'FreqCut','ResponseCut','TopSeq','ReadCut'};
type=types{handles.thresh_type.Value};
ScoringMatrix=handles.scoringmatrix.String{handles.scoringmatrix.Value};
GapPen=str2num(handles.GapPen.String);
threshold=str2num(handles.threshold.String);
clusterthreshold=str2num(handles.clusterthreshold.String)/100;
showlegend=1;
freqplot=1;
readplot=0;

switch handles.thresh_type.Value
    case 1
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 2
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 3
        filecutparam=str2num(handles.threshtypeval.String);
    case 4
        filecutparam=str2num(handles.threshtypeval.String);
end


%%Collecte Sequence data from each file selected
for i=1:size(handles.files.Value,2)
   Input.fileread=handles.fileref{handles.files.Value(i)};
   eval(['Input.' type '=filecutparam;'])
   
   Output=ParseAdaptiveFile(Input);
   Seq=Output.AA;
   
    for j=1:size(Seq,1)
        string1=num2str(i);
        string2=num2str(j);
        stringprint=strcat(string1,'_',string2);
        SeqPass(i).seq(j).Header=stringprint;
        SeqPass(i).seq(j).Sequence=Seq(j);
    end
    SeqPass(i).freq=Output.Freq;
   
end


%%Creates one data structure to pass to calculate distance matrix
FSeqPass=[];
FFreqPass=[];
for i=1:size(handles.files.Value,2)
    FSeqPass=[FSeqPass,SeqPass(i).seq];
    FFreqPass=[FFreqPass;SeqPass(i).freq];
end


%%Calculates all pairwise distances for all sequences 
FFreqPass=cell2mat(FFreqPass);
distances=CalculateDistance(FSeqPass,ScoringMatrix,GapPen);
%Creates Dendrogram
PhyloTree=seqlinkage(distances,'average',FSeqPass);

%Plots Dendrogram
h=plot(PhyloTree,'Type','equalangle','LeafLabels',false,'TerminalLabels',false)
hold on;

set(h.BranchDots,'MarkerSize',.00001)
set(h.LeafDots,'MarkerSize',.0001)


%Overlays circles representing frequency of 
if freqplot==1
    freqmax=max(FFreqPass);
    LineWidthMax=10000;
    
for t=1:size(h.leafNodeLabels,1)
    idtemp=h.leafNodeLabels(t).String;
    index = find(strcmp({FSeqPass.Header}, idtemp)==1);
    freqtemp=FFreqPass(index);
    SizeData(t)=freqtemp*(LineWidthMax/freqmax);
    Xcenter(t)=h.BranchLines(t).XData(2);
    Ycenter(t)=h.BranchLines(t).YData(2);
    
    stringcheck=strsplit(idtemp,'_');
    colorid=str2num(cell2mat(stringcheck(1)));
    color(:,t)=transpose(colorspec1(colorid).spec);
end

scatter(Xcenter,Ycenter,SizeData,transpose(color),'filled','MarkerFaceAlpha',0.5)

end

%%Overlays legend to correspond to each sample
if showlegend==1;
x1=xlim;
y1=ylim;
for i=1:size(handles.files.Value,2)
    xc1=x1(1)+.015*(x1(2)-x1(1));
    if i==1;
        yc1=y1(1)+.025*(y1(2)-y1(1));
    else
        yc1=yc1+.05*(y1(2)-y1(1));
    end
    sg=scatter(xc1,yc1,'filled');
    pause(.1);
    sMarkers=sg.MarkerHandle;
    color1=transpose(colorspec1(i).spec);
    color1=[color1;0];
    color2=transpose(colorspec2(i).spec);
    sMarkers.FaceColorData = uint8(255*color2);
    sMarkers.EdgeColorData = uint8(255*color1);
    sMarkers.Size=20;
    text(x1(1)+0.025*(x1(2)-x1(1)),yc1,char(handles.files.String{handles.files.Value(i)}),'Interpreter','none')
    
end

end



% --- Executes on button press in comp2.
function comp2_Callback(hObject, eventdata, handles)
% hObject    handle to comp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Compare two files and determine % of response/% of sequences that are
%%novel in respect to another file

hbox=msgbox('Please wait...');
set(hbox.Children(1),'Visible','off')

types={'FreqCut','ResponseCut','TopSeq','ReadCut'};
type=types{handles.thresh_type.Value};
ScoringMatrix=handles.scoringmatrix.String{handles.scoringmatrix.Value};
GapPen=str2num(handles.GapPen.String);
threshold=str2num(handles.threshold.String);
homology=1/(1+threshold);
clusterthreshold=str2num(handles.clusterthreshold.String)/100;

switch handles.thresh_type.Value
    case 1
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 2
        filecutparam=str2num(handles.threshtypeval.String)/100;
    case 3
        filecutparam=str2num(handles.threshtypeval.String);
    case 4
        filecutparam=str2num(handles.threshtypeval.String);
end

%%Run ImmunoMap Metrics on 1 Sample
Input.fileread=handles.fileref{handles.sample1sel.Value};
eval(['Input.' type '=filecutparam;'])
Output1=ParseFile(Input);
Data1=ImmunoMap(Input,ScoringMatrix,GapPen,threshold,clusterthreshold);

%%Run ImmunoMap Metrics on 2nd sample
Input.fileread=handles.fileref{handles.sample2sel.Value};
Output2=ParseFile(Input);
Data2=ImmunoMap(Input,ScoringMatrix,GapPen,threshold,clusterthreshold);

%%Calculate distance matrix for all sequences in 1 sample to all sequences
%%in another sample
Data=DistanceVector2Seq(transpose(Output1.AA),transpose(Output2.AA),ScoringMatrix,GapPen);

DistanceMatrix=Data.DistanceMatrix;

%Calculate %Novel 
Check=DistanceMatrix<=threshold;
Check=sum(Check);
Check=Check>0;
Check=~Check;
DataFinal.NovelClonesPerc=100*(sum(Check)/size(Check,2));
DataFinal.NovelContribution=100*sum(Check.*transpose(cell2mat(Output2.Freq)));

%%Compare Dominant Motifs between sample 1 & 2

try
seqstore21=Data1.Motifs;
seqstore22=Data2.Motifs;

for i=1:size(seqstore21,2);
     clear seq1
    n=1;
    for j=1:size(seqstore21(i).seq,2)
        seqtemp=seqstore21(i).seq(j);
        if ~isempty(strfind(char(seqtemp),'-'))
            seqtemp(regexp(seqtemp,'-'))=[];
        end
        seq1{n}=char(seqtemp);
        n=n+1;
    end
    
    %%Calculate centroid sequence from each cluster of sequences before
    %%comparing centroids to centroids. 
    [seqc,index]=DetermineCentroidSequence(seq1,ScoringMatrix,GapPen); 
    seq1c{i}=seqc;
    
end

for i=1:size(seqstore22,2);
    clear seq2
     n=1;
    for j=1:size(seqstore22(i).seq,2)
        seqtemp=seqstore22(i).seq(j);
        if ~isempty(strfind(char(seqtemp),'-'))
            seqtemp(regexp(seqtemp,'-'))=[];
        end
        seq2{n}=char(seqtemp);
        n=n+1;
    end
    
    [seqc,index]=DetermineCentroidSequence(seq2,ScoringMatrix,GapPen);
    
    seq2c{i}=seqc;
end

%%Computer distance vector of all centroids in one sample to all centroids
%%in second sample
DataOut=DistanceVector2Seq(seq1c,seq2c,ScoringMatrix,GapPen);

%Homologous clusters are defined as pairs of sequences that have a distance
%below user-defined threshold
HomologousClusters=DataOut.DistanceMatrix<threshold;

n=1;
for i=1:size(HomologousClusters,1);
    for j=1:size(HomologousClusters,2);
        if HomologousClusters(i,j)==1;
            Pair(n,1)=n;
            Pair(n,2)=i;
            Pair(n,3)=j;
            n=n+1;
        end
    end
end

Pair=Pair(:,[2,3]);

for i=1:size(Pair,1);
    xwrite=char(strcat(num2str(Pair(i,1)),{' - '},num2str(100*Data1.Motifs(Pair(i,1)).FreqSum),'%'));
    PairOut{i,1}=xwrite;
    xwrite=char(strcat(num2str(Pair(i,2)),{' - '},num2str(100*Data2.Motifs(Pair(i,2)).FreqSum),'%'));
    PairOut{i,2}=xwrite;
end


handles.novelperc.String=num2str(DataFinal.NovelClonesPerc);
handles.novelresponse.String=num2str(DataFinal.NovelContribution);
handles.sample1motifs.String=num2str(size(seqstore21,2));
handles.sample2motifs.String=num2str(size(seqstore22,2));
column_name1=char(strcat({'Motifs - '},handles.sample1sel.String{handles.sample1sel.Value}));
column_name2=char(strcat({'Motifs - '},handles.sample2sel.String{handles.sample2sel.Value}));

handles.hommotifs.ColumnName={column_name1,column_name2};
if exist('Pair')
    handles.hommotifs.Data=PairOut;
else
    handles.hommotifs.Data=[];
end

catch
     handles.hommotifs.Data=[];
     handles.novelperc.String=num2str(DataFinal.NovelClonesPerc);
     handles.novelresponse.String=num2str(DataFinal.NovelContribution);
     handles.sample1motifs.String=num2str(Data1.NumberOfMotifs);
     handles.sample2motifs.String=num2str(Data2.NumberOfMotifs);
     close(hbox);
end

close(hbox);

guidata(hObject,handles);



function novelperc_Callback(hObject, eventdata, handles)
% hObject    handle to novelperc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of novelperc as text
%        str2double(get(hObject,'String')) returns contents of novelperc as a double


% --- Executes during object creation, after setting all properties.
function novelperc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to novelperc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function novelresponse_Callback(hObject, eventdata, handles)
% hObject    handle to novelresponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of novelresponse as text
%        str2double(get(hObject,'String')) returns contents of novelresponse as a double


% --- Executes during object creation, after setting all properties.
function novelresponse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to novelresponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample1motifs_Callback(hObject, eventdata, handles)
% hObject    handle to sample1motifs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sample1motifs as text
%        str2double(get(hObject,'String')) returns contents of sample1motifs as a double


% --- Executes during object creation, after setting all properties.
function sample1motifs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample1motifs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample2motifs_Callback(hObject, eventdata, handles)
% hObject    handle to sample2motifs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sample2motifs as text
%        str2double(get(hObject,'String')) returns contents of sample2motifs as a double


% --- Executes during object creation, after setting all properties.
function sample2motifs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample2motifs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sample1sel.
function sample1sel_Callback(hObject, eventdata, handles)
% hObject    handle to sample1sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sample1sel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sample1sel


% --- Executes during object creation, after setting all properties.
function sample1sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample1sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sample2sel.
function sample2sel_Callback(hObject, eventdata, handles)
% hObject    handle to sample2sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sample2sel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sample2sel


% --- Executes during object creation, after setting all properties.
function sample2sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample2sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
