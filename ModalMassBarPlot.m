function ModalMassBarPlot(varargin)
% 
% ModalMassBarPlot
% 
% INPUTS:
%   Data
% 
% Created By:
%   Mateo G. H. (2021/06/10)

%%%%%%%%%%%%%%%%%%%% ------------------------------------------------------
%%% Assign Input %%%
%%%%%%%%%%%%%%%%%%%%
Data = varargin{1};
[NumModes,NumCoord] = size(Data);
%%% Graph -----------------------------------------------------------------
GraphProp = GraphicalProperties('Calibri Light',10,1.2);
wid = 15;
hei = 3;
for ii = 1:NumModes
Fig = figure('Units','centimeters','Position',[10 10 wid hei]);
Ax1 = axes(Fig); %#ok<LAXES>
%%%
Pl1 = bar(Data(ii,:)); view(90,90);
Pl1.FaceColor = [1,1,1]*0.6;
Pl1.EdgeColor = [1,1,1]*0.2;
Pl1.LineWidth = 0.5;
%%%
Ax1.XLim = [0.5, 0.5+NumCoord];
Ax1.YLim = [0 130];
Ax1.XLabel.String = 'Dirección';
Ax1.YLabel.String = 'Masa Modal (%)';
switch NumCoord
    case 1
        Ax1.XTickLabel = {'X'};
    case 2
        Ax1.XTickLabel = {'X','Y'};
    case 3
        Ax1.XTickLabel = {'X','Y','Z'};
end
%%% Text
for jj = 1:NumCoord
    text(jj,Data(ii,jj)+2,[num2str(Data(ii,jj),'%.2f'),'%'],...
        'FontName',GraphProp.fontname,'FontSize',GraphProp.fontsize-1,'Color',[1,1,1]*0.2,...
        'VerticalAlignment','top','HorizontalAlignment','left',...
        'VerticalAlignment','middle');
end
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
