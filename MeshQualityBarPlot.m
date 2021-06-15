function MeshQualityBarPlot(varargin)
%
% MeshQualityBarPlot
%
% INPUTS:
%   WorkingFolder
%   FileName
%
% Created By:
%   Mateo G. H. (2021/06/10)

%%%%%%%%%%%%%%%%%%%% ------------------------------------------------------
%%% Assign Input %%%
%%%%%%%%%%%%%%%%%%%%
WorkingFolder = varargin{1};
FileName = varargin{2};
%%% GetCases
% Cases = 1, if ASPE exists
% Cases = 2, if JACR exists
% Cases = 3, if WARP exists
Cases = [];
% ASPE
if ~isempty(FileName.ASPE)
    try
        Cases(end+1) = 1;
        ASPE = load(...
            [WorkingFolder,'\',FileName.ASPE]...
            );
        ASPEwrn = 20;
        ASPEerr = 1000;
    catch
    end
end
% JACR
if ~isempty(FileName.JACR)
    try
        Cases(end+1) = 2;
        JACR = load(...
            [WorkingFolder,'\',FileName.JACR]...
            );
        JACRwrn = 30;
        JACRerr = 40;
    catch
    end
end
% WARP
if ~isempty(FileName.WARP)
    try
        Cases(end+1) = 3;
        WARP = load(...
            [WorkingFolder,'\',FileName.WARP]...
            );
        WARPwrn = 0.1;
        WARPerr = 0.4;
    catch
    end
end
%%% Graph -----------------------------------------------------------------
GraphProp = GraphicalProperties('Calibri Light',10,1.2);
wid = 7.5;
hei = 3.5;
for countCase = Cases
    Fig = figure('Units','centimeters','Position',[10 10 wid hei]);
    Ax1 = axes(Fig); %#ok<LAXES>
    %%%
    switch countCase
        case 1 % ASPE
            Data = ASPE(:);
            WarningLimit = ASPEwrn;
            ErrorLimit   = ASPEerr;
            XLabel       = 'Aspect Ratio';
            disp(['ASPE: ',num2str(mean(Data)),' ± ',num2str(std(Data))])
        case 2 % JACR
            Data = JACR(:);
            WarningLimit = JACRwrn;
            ErrorLimit   = JACRerr;
            XLabel       = 'Jacobian Ratio';
            disp(['JACR: ',num2str(mean(Data)),' ± ',num2str(std(Data))])
        case 3 % WARP
            Data = WARP(:);
            WarningLimit = WARPwrn;
            ErrorLimit   = WARPerr;
            XLabel       = 'Warping Factor';
            disp(['WARP: ',num2str(mean(Data)),' ± ',num2str(std(Data))])
    end
    %%%
    if countCase == 3
        [ZData,ZEdges] = histcounts(Data,'BinWidth',0.005);
    else
        [ZData,ZEdges] = histcounts(Data,'BinMethod','integers');
    end
    ZData = 100*ZData./length(Data);    ZData = ZData(:);
    XData = ZEdges(2:end);              XData = XData(:);
    Plot = bar(XData,ZData,'FaceColor','flat');
    %%% ColorMap
    ColorMap_OK = [...% <Warning
        interp1([1;0],[0 1 1; 0 0 1],linspace(0,1,128));...
        interp1([1;0],[1 1 0; 0 1 1],linspace(0,1,128))];
    ColorMap_NotOK = autumn(256); % >Warning
    ColorMap_NotOK = ColorMap_NotOK(end:-1:1,:);
    %%% Valores inferiores al warning
    WarningInd = XData<WarningLimit;
    if any(WarningInd)
        ColorMapInd = linspace(0,1,256);
        ColorMapVal = XData(WarningInd)./WarningLimit;
        Plot.CData(WarningInd,:) = [...
            interp1(ColorMapInd,ColorMap_OK(:,1),ColorMapVal),...
            interp1(ColorMapInd,ColorMap_OK(:,2),ColorMapVal),...
            interp1(ColorMapInd,ColorMap_OK(:,3),ColorMapVal)...
            ];
    end
    %%% Valores superiores al warning
    ErrorInd = XData>=WarningLimit & XData<ErrorLimit;
    if any(ErrorInd)
        ColorMapInd = linspace(WarningLimit,ErrorLimit,256);
        ColorMapVal = XData(ErrorInd);
        Plot.CData(ErrorInd,:) = [...
            interp1(ColorMapInd,ColorMap_NotOK(:,1),ColorMapVal),...
            interp1(ColorMapInd,ColorMap_NotOK(:,2),ColorMapVal),...
            interp1(ColorMapInd,ColorMap_NotOK(:,3),ColorMapVal)...
            ];
    end
    ErrorInd = XData>=ErrorLimit;
    if any(ErrorInd)
        Plot.CData(ErrorInd,:) = repmat(ColorMap_NotOK(end,:),sum(ErrorInd),1);
        %%%
        hold(Ax1,'on');
        plot([1,1]*ErrorLimit,[-10,200],...
            'LineStyle','--',...
            'Color',ColorMap_NotOK(end,:),...
            'LineWidth',1 ...
            );
    end
    %%% Warning Line
    hold(Ax1,'on');
    plot([1,1]*WarningLimit,[-10,200],...
        'LineStyle','--',...
        'Color',ColorMap_OK(end,:),...
        'LineWidth',1 ...
        );
    %%% Error Line
    if any(max(XData(:))>ErrorLimit)
        hold(Ax1,'on');
        plot([1,1]*ErrorLimit,[-10,200],...
            'LineStyle','--',...
            'Color',ColorMap_NotOK(end,:),...
            'LineWidth',1 ...
            );
    end
    %%% Graphical Properties
    Plot.EdgeColor = [1,1,1]*0.2;
    Plot.LineWidth = 0.5;
    %%%
    Ax1.XLim = [0, max([1.1*WarningLimit, max(XData(:))])];
    Ax1.YLim = [0, 110];
    Ax1.XLabel.String = XLabel;
    Ax1.YLabel.String = 'Elementos (%)';
    %%%
    set(Ax1,GraphProp.Prop);
    set(Ax1.XAxis,GraphProp.PropXA);
    set(Ax1.YAxis,GraphProp.PropYA);
    set(Ax1.Title,GraphProp.PropT);
    set(Ax1.XLabel,GraphProp.PropXL);
    set(Ax1.YLabel,GraphProp.PropYL);
    %%%
    Ax1.XMinorGrid = 'off';
    Ax1.YMinorGrid = 'on';
    Ax1.XGrid = 'on';
    Ax1.YGrid = 'on';
end
end
