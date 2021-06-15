%
% MeshQualityBarPlot_main
%
% Created By:
%   Mateo G. H. (2021/06/10)

clc, clearvars, close all;
%%%%%%%%%%%%% -------------------------------------------------------------
%%% Input %%%
%%%%%%%%%%%%%
WorkingFolder = 'C:\Users\Usuario\Google Drive\01 Trabajo\01 Idvia\04-Capacitaciones\2021 - 05 - 03 - Mallado\02-Trabajados\APDL - M2, Beam';
% Filename inside WorkingFolder or []
FileName.ASPE = 'Mesh_Check_ASPE.txt';
FileName.JACR = 'Mesh_Check_JACR.txt';
FileName.WARP = 'Mesh_Check_WARP.txt';

%%%%%%%%%%%%%%%%%%%%% -----------------------------------------------------
%%% Call Function %%%
%%%%%%%%%%%%%%%%%%%%%
MeshQualityBarPlot(WorkingFolder,FileName);
