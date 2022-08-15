clc
clear
path1=input('Audio file location :');
path2=input('image file location :');
[y,~]=audioread(path1); %reading the audio file in the given path :-
L=round(length(y)^(0.5),0); % to get an integer value
Y=y(1:L^2);%to get all the values in the array
x=(1:L^2);%position of values in the array
x=(mod(x,2)==0);%defining a new matrix which replaces the negative values of the original matrix with zero 
Y=Y.*x;
S=Y;
Y=round(Y,6);%rounding the value till the sixth decimal place
tpos=(abs(Y)+Y)./2;%to get the positive values in one matrix
tneg=(abs(Y)-Y)./2;%to get the negative values in one matrix
tpos=reshape(tpos,L,L);%reshaping the given matrix into two halves
tneg=reshape(tneg,L,L);%reshaping the given matrix into two halves
tpos=abs(tpos'); %returns the absolute value
tneg=abs(tneg');
mp=(tpos>0.999).*tpos;
mn=(tneg>0.999).*tneg;
%Splitting the array into 3 parts that are three colours=Red,Blue and Green
%For Positive Values
r=((tpos<0.999).*tpos)*100;
R=floor(r);
g=((r-R).*100);
G=floor(g);
B=(g-G).*100;
totp=cat(3,(R./100)+mp,G./100,B./100); %Concatenation of three arrays of red, green and blue colours
%Now for the negative values :-
rn=((tneg<0.999).*tneg)*100;
Rn=floor(rn); %Red Colour
gn=((rn-Rn).*100); %Green Colour
Gn=floor(gn); 
Bn=(gn-Gn).*100; %Blue Colour
totn=cat(3,(Rn./100)+mn,Gn./100,Bn./100); %Concatenation of three strings
total=[totp totn]; % total matrix with both the positive and negative matrices
imwrite(totp,path2); %positive image
imwrite(totn,path2); %negative image
imwrite(total,path2);
disp('file created');