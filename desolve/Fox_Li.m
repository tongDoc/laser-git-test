clear;
clc;

lambda = 1.064*10^-3;
k = 2*pi/lambda;
a = 1;
fnum = 6.25; %Fresnel number
z = a^2/fnum/lambda;
num = ceil(a/(sqrt(z*lambda/20)));
pu = input(sprintf('网格划分数目应该不小于%d,默认网格数为200 ok or no?',num),'s');
if strcmp(pu,'ok')
	M = 200;
else
	M = input('径向网格数:');
end

tic;
repet = 300;

r = linspace(-a,a,M);
drho = 2*a/(M-1);
u1 = zeros(1,M);
u0 = ones(1,M);

for iter = 1:repet*2
	for gk = 1:M
		subu = sqrt(j/lambda/z)*exp(-j*k*z/2).*exp(-j*k*(r-r(gk)).^2/z/2).*u0.*drho;
		u1(gk) = sum(subu(:));
	end
	u0=u1;
end

Ie = u1.*conj(u1);
Ie = Ie./max(Ie(:));

plot(r,Ie,'k');

hold on
