%% main
V=17;  %巡航速度
    Ma=V/340;
DES=1.225;

wing_a=5;    %unit m
%wing_c=0,4;  %unit m




%----------------------------------
m=12;  %重量 kg
%----------------------------------


%E67
CL_ALP_AIRFOIL=6.4;  %E67的升力线斜率


AR=18;  %展弦比
lmd=0.3;%根梢比
AA=-5*(180/pi);   %后掠角


body_b=0.4;%这个值根据载荷的形式人为选取
body_d=2.5;%这个值根据载荷的形式人为选取
%% areodynamics
CL_MAX=1.6;

%lift
    A2=sqrt(1-Ma^2);
    A3=0.95;
A1=AR^2*A2^2/A3;
A4=1+tan(AA)^2/A2^2;
FFF=1.07*(1+body_b/wing_a)^2;
CL_ALPHA=(((2*pi*AR)*((wing_a-body_b)/wing_a))*FFF)/(2+sqrt(4+A1*A4));
CL=CL_ALPHA*(3*(180/pi);

S=m*9.8/(CL_ALPHA*(3*(180/pi))*0.5*DES*V*V);
wing_c=S/wing_a;
AR=wing_a/wing_c;

%增升装置
V_min=sqrt(m*9.8/(0.9*CL_MAX*0.5*DES*S));

%阻力

Re1=(DES*V*wing_c)/18.239;
Re2=(DES*V*body_d)/18.239;
C_D0wing=0.455/(log10(Re1))^2.58;
C_D0body=0.455/(log10(Re2))^2.58;

YT_wing=(1+0.6/0.4*0.1+100*0.1*4)*(1.34*Ma^1.8*1);
YT_body=(1+60/(body_d/body_b)^3+0.0025*(body_d/body_b));

S_WING=2.14*S;
S_BODY=11.8*body_b*sqrt((pi/4)*(body_b*body_d));


C_D0=(C_D0wing*YT_wing*S_WING+C_D0body*YT_body*S_BODY)/S;

C_DI=((0.38*CL^2)/(AR-0.8*CL*(AR-1)));

CD=C_D0+C_DI;
D=CD*S*0.5*DES*V^2;

tt=0.1; %翼型平均厚度
C_root=2*S/(wing_a*(1+lmd));%  翼根弦长
CC=C_root*0.4;
t=tt*C_root;    %单边的梁高
t_wood_1=0.01;  %主翼梁厚度
t_wood_2=0.005; %辅翼梁厚度
t_surface=0.002;%蒙皮厚度
I_1=(t_wood_1*t^3)/12;
I_2=(t_wood_2*t^3)/12;
I_3=(t_wood_3^3*CC)/12+t_wood_3*CC*(t/2)^2;
I_4=(t_wood_3^3*CC)/12+t_wood_3*CC*(t/2)^2;
I_root=I_1+I_2+I_3+I_4;

x=0:0.01*wing_a:wing_a;
y1=sqrt(1-((2*x)/wing_a)^2);
M1=trapz(x,y1);
MMM=(m/2)/M1;

y2=sqrt(1-((2*x)/wing_a)^2)*x*MMM;
M2=trapz(x,y2);

stress=(M2*(t/2))/I_root;

