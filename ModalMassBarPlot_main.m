% 
% ModalMassBarPlot_main
% 
% Created By:
%   Mateo G. H. (2021/06/10)

clc, clearvars, close all;
%%%%%%%%%%%%%%%%%% --------------------------------------------------------
%%% Repository %%%
%%%%%%%%%%%%%%%%%%
warning('off')
addpath('C:\Users\Mateo\Google Drive\01 Trabajo\GIT\APDL')
addpath('C:\Users\Usuario\Google Drive\01 Trabajo\GIT\APDL')
warning('on')

%%%%%%%%%%%%% -------------------------------------------------------------
%%% Input %%%
%%%%%%%%%%%%%
File = 'C:\Users\Usuario\Google Drive\01 Trabajo\01 Idvia\04-Capacitaciones\2021 - 05 - 03 - Mallado\02-Trabajados\APDL - M2, Beam\MasaModalRatio_XYZ.txt';
Data = 100*load(File); % (%)

%%%%%%%%%%%%%%%%%%%%% -----------------------------------------------------
%%% Call Function %%%
%%%%%%%%%%%%%%%%%%%%%
ModalMassBarPlot(Data);
