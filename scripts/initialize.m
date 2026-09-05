
% Initializations

filelist = dir(strcat(pwd,'/Data/*.mat'));                                  % get all .mat files in Data directory
    
varidx   = cellfun(@(s) contains (s, 'vars.mat'), {filelist.name});
varfile  = fullfile({filelist(varidx).folder},{filelist(varidx).name});
filelist = fullfile({filelist(~varidx).folder},{filelist(~varidx).name});

if isempty(varfile) || isempty(filelist)                                   
    error("  >> empty Data Directory <<")
    global canceled
    canceled=true;
    return
end

load(varfile{end})
Nfiles = length(filelist);                                                  
clear('varidx','varfile')

RMinIdx = ceil(RMin/((2*RMax)/NFFT));                                       
Rvec    = 0:(2*RMax)/NFFT:RMax;                       Rvec(Rvec<RMin)=[];   
cf      = cos(asin(dStreet./Rvec));                                         
Rvec    = Rvec.*cf;                                                         
RMin    = RMin*cos(asin(dStreet/RMin));                                     
RMax    = RMax*cos(asin(dStreet/RMax));                                     
vvec    = 3.6*(c0/(fc*2*PRI))*(-0.5:1/NFFT:0.5);  vvec=vvec(1:end-1);       

xtract  = false;                                                            % flag for running xtraction


closediag = dialog('Position',[0 0 100 50], 'Name','');                     % definition of closing dialog
uicontrol(...
'Parent',closediag, ...
'Style','pushbutton', ...
'String','PAUSE', ...
'Units','normalized', ...
'Position',[0.05 0.1 0.4 0.8], ...
'Callback',@pausing);
uicontrol(...
'Parent',closediag, ...
'Style','pushbutton', ...
'String','CANCEL', ...
'Units','normalized', ...
'Position',[0.5 0.1 0.4 0.8], ...
'Callback',@canceling, ...
'Tag','stop');
set(closediag,'WindowStyle','alwaysontop');
movegui(closediag, 'northeast')


fig = figure(1);                                                            % initialization of  window
if maxfig
 fig.WindowState = 'maximized';
 set(gcf, 'MenuBar','none', 'ToolBar','none')
 set(gca,'Units','normalized','InnerPosition',[0.025 0.05 0.97 0.9175])
else
 movegui('northwest')
end


global canceled                                                             
canceled = false;

function pausing(~,~)                                                      
    datatip
    pause(20)
    figure(1)
    dcm = datacursormode(gcf);
    set(dcm,'Enable','off')
end

function canceling(~,~)                                                    
    datatip
    delete(gcbf)
    clear('closediag')
    global canceled
    canceled=true;
    return
end
