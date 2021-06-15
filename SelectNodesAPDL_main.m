% 
% SelectNodesAPDL_main
% 
% Created By:
%   Mateo G. H. (2021/06/12)

clc, clearvars, close all;
%%%%%%%%%%%%%%%%%% --------------------------------------------------------
%%% Repository %%%
%%%%%%%%%%%%%%%%%%
warning('off')
addpath('C:\Users\Mateo\Google Drive\01 Trabajo\GIT\APDL')
addpath('C:\Users\Usuario\Google Drive\01 Trabajo\GIT\APDL')
warning('on')
%%%%%%%%%%%%%%%%%%%%% -----------------------------------------------------
%%% Assign Inputs %%%
%%%%%%%%%%%%%%%%%%%%%
X   = 0.05+(1:7)*0.3875;
Y   = 0*X;
Z   = 0*X;
XYZ = [X(:),Y(:),Z(:)];
Tol = 0.01;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -----------------------------------
%%% Save Variable and Call Function %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('SensorLocation.mat','XYZ','-ascii')
SelectNodesAPDL(XYZ,Tol,pwd);
