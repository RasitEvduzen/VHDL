clc,clear all,close all;
%% SÝSO YSA MODEL 
x  = 3.2;
Wg = 0.7;
Wc = 0.2;
bg = 0.8;
bc = 0.3;
y  = [Wc*[tanh([(x*Wg)+bg])]]+bc;


% mul latency 14 clock
% add latency 14 clock
% div latency 14 clock
% exp latency 17 clock 

