figure;
clear all;
%特征线法求解程函方程
%========范围设置=============
xsta=0;
xend=8000;
dx=10;
zsta=-4000;
zend=0;
dz=10;
source=[4000,0];
dtheta=15*pi/180;
theta=[-pi/3:dtheta:pi/3];
ds=1.0;
%
%=========显示速度结构=========
%
x=[xsta:dx:xend];
z=[zsta:dz:zend];
[x,z]=meshgrid(x,z);
v=-0.5*z+1000+0.25*x;%速度结构，RK_f也要修改
pcolor(x,z,v)
colormap(flipud(jet))
set(gca,'position',[0.1,0.2,0.8,0.6])
 set(gca,'xaxislocation','top')
set(gca,'xtick',[0:2000:8000]);
set(gca,'xticklabel',{'0','2','4','6','8'});
set(gca,'ytick',[-4000:1000:0]);
set(gca,'yticklabel',{'4','3','2','1','0'});
shading interp
h=colorbar('position',[0.94 0.2 0.01 0.6]);
set(h,'ytick',[1000:1000:5000]);
set(h,'yticklabel',{'1','2','3','4','5'});
set(get(h,'title'),'string','km/s')
xlabel('Lateral Location(km)')
ylabel('Depth (km)')
hold on
%
%========4阶-龙格库塔=============
%
 x0=source(1,1);z0=source(1,2);
n=length(theta);
for i=1:1:n
   px=sin(theta(i))/(1000+0.25*x0-0.5*z0);
   pz=-cos(theta(i))/(1000+0.25*x0-0.5*z0);%初始条件
    y=[x0,z0,px,pz]';
    path=[x0,z0];
    while(y(1)>=xsta & y(1)<=xend & y(2)<=zend & y(2)>=zsta)
        tmp=zeros(4,1);
        k=RK_f(y);
        tmp=tmp+k;
        k=RK_f(y+ds/2*k);
        tmp=tmp+2*k;
        k=RK_f(y+ds/2*k);
        tmp=tmp+2*k;
        k=RK_f(y+ds*k);
        tmp=tmp+k;
        y=y+ds/6*tmp;
        path=[path;[y(1),y(2)]];
    end
    plot(path(:,1),path(:,2),'k','LineWidth',1.5);
    hold on
end
%
%======标上震源=======
%
plot(source(1,1),source(1,2),'rp','LineWidth',1.5)
