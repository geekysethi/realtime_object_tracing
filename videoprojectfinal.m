imaqreset
clc
close all
clear all
count=0;
c=0;
vid=videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',inf);
triggerconfig(vid,'manual'); 
start(vid);
pause(2);
trigger(vid);
im=getdata(vid);

 im1=im(:,:,1);
im1=fliplr(im1);
im2=im(:,:,2);
im2=fliplr(im2);
im3=im(:,:,3);
im3=fliplr(im3);
im9=cat(3,im1,im2,im3); %fliped image
im=rgb2hsv(im9);

[x1 y1 k1]=impixel(im);
[x2 y2 k2]=impixel(im);
[x3 y3 k3]=impixel(im);

th=0.50;
r_min1=k1(1)-k1(1)*th;
r_max1=k1(1)+k1(1)*th;
g_min1=k1(2)-k1(2)*th;
g_max1=k1(2)+k1(2)*th;
b_min1=k1(3)-k1(3)*th;
b_max1=k1(3)+k1(3)*th;

r_min2=k2(1)-k2(1)*th;
r_max2=k2(1)+k2(1)*th;
g_min2=k2(2)-k2(2)*th;
g_max2=k2(2)+k2(2)*th;
b_min2=k2(3)-k2(3)*th;
b_max2=k2(3)+k2(3)*th;

r_min3=k3(1)-k3(1)*th;
r_max3=k3(1)+k3(1)*th;
g_min3=k3(2)-k3(2)*th;
g_max3=k3(2)+k3(2)*th;
b_min3=k3(3)-k3(3)*th;
b_max3=k3(3)+k3(3)*th;


s=size(im);



for l=1:200
    trigger(vid);
im=getdata(vid);
  im1=im(:,:,1);
im1=fliplr(im1);
im2=im(:,:,2);
im2=fliplr(im2);
im3=im(:,:,3);
im3=fliplr(im3);
im9=cat(3,im1,im2,im3); %fliped image
im=rgb2hsv(im9);

im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);
new_im=zeros(s(1),s(2));



ind= find(im_r>r_min1&im_r<=r_max1&im_g>g_min1&im_g<=g_max1&im_b>b_min1&im_b<=b_max1);
           
      new_im(ind)=1;

ind1= find(im_r>r_min2&im_r<=r_max2&im_g>g_min2&im_g<=g_max2&im_b>b_min2&im_b<=b_max2);
           
      new_im(ind1)=1;
      
ind2= find(im_r>r_min3&im_r<=r_max3&im_g>g_min3&im_g<=g_max3&im_b>b_min3&im_b<=b_max3);
           
      new_im(ind2)=1;

      
                imshow(im9);
                  hold on

      
              new_im1=bwareaopen(new_im,400); 
              aa=bwconncomp(new_im1);
              m1=aa.NumObjects;
        if(m1>2&&m1<4)      
              
      
          th=0:pi/100:2*pi;

        st=regionprops(aa,'All');
        ll=length(st);        
        
%calculating centriods and dia.
%1
         x4=st(1).Centroid(1);
         y4=st(1).Centroid(2);
         R4=st(1).EquivDiameter/2;
         X4=x4+R4*cos(th);
         Y4=y4+R4*sin(th);
%2
        x5=st(2).Centroid(1);
        y5=st(2).Centroid(2);
        R5=st(2).EquivDiameter/2;
        X5=x5+R5*cos(th);
        Y5=y5+R5*sin(th);
%3  
         x6=st(3).Centroid(1);
         y6=st(3).Centroid(2);
         R6=st(3).EquivDiameter/2;
         X6=x6+R6*cos(th);
         Y6=y6+R6*sin(th);
     
     
 %distance
 kk1=[x4 x5;y4 y5];
 d1=pdist(kk1);
 kk2=[x6 x5;y6 y5];
 d3=pdist(kk2);
 kk3=[x4 x6;y4 y6];
 d2=pdist(kk3);
 
 %ploting
 
 
     plot(x4,y4,'*m','LineWidth',3.5);
     plot(X4,Y4,'y','lineWidth',2.5);
     plot(x5,y5,'*m','LineWidth',3.5);
     plot(X5,Y5,'y','lineWidth',2.5);
     plot(x6,y6,'*m','LineWidth',3.5);
     plot(X6,Y6,'y','lineWidth',2.5);
%calculating line
     x7=[x4,x5];
     y7=[y4,y5];
     plot(x7,y7,'k','LineWidth',2);
     text(x7,y7,num2str(d1),'HorizontalAlignment','center');

     x8=[x4,x6];
     y8=[y4,y6];
     plot(x8,y8,'k','LineWidth',2);
     text(x8,y8,num2str(d2),'HorizontalAlignment','center');

     x9=[x6,x5];
     y9=[y6,y5];
     plot(x9,y9,'k','LineWidth',2);
     text(x9,y9,num2str(d3),'HorizontalAlignment','center');
     hold off
    
end
ll=0;
end
stop(vid);
delete(vid);
clear('vid');
imaqreset;






