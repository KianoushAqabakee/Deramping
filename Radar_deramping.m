close all;
clear all;
clc;
%% 
% Kianoush Aqabakee  student ID: 9512103311
%% Chirp signal generation
omega=linspace(-pi,pi,1024);
t=0:50000;
a=zeros(1,4001);
T=t(1:10000);

signal=exp(j*(0.1*T+0.0006*T.*T));
chirp=cat(2,signal,a);
%% f0 signal generation with random samples
n=10; % number of points
x_n=randperm(20000,n); % for dirac
sigma_n=randperm(3*n,n); % for sigma
x=linspace(1,20000,20000);
f0=zeros(size(x));
for i = 1:length(x_n)
    f0(x==x_n(i))=sigma_n(i);
end
figure
stem(x,f0)
%% Deramping
s=conv(f0,chirp,'same');
sc=abs(conv(conj(s),flip(chirp),'same'));
a=0;
b=0;
for i=1:1:length(f0)
    a=a+(i-1)*f0(i)^2;
    b=b+x(i)^2;
end
Xc=a/b;
%% Plot
figure
plot(f0*(max(sc)/max(f0)),'Linewidth',2); 
hold on;
plot(sc,'Linewidth',1);legend('Targets','predicted Target'); 
grid('on');
