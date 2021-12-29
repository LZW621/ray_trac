function k=RK_f(y)
    %y=[x,z,px,pz]';
    k=zeros(4,1);
    v=1000-0.5*y(2)+0.25*y(1);
    k(1)=v*y(3);
    k(2)=v*y(4);
    k(3)=-0.25/v^2;
    k(4)=0.5/v^2;
end
