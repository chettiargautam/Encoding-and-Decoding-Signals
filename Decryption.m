clc;
clear;
disp('ddd');
Fs=44100; %Peoples' ears can hear sound whose frequencies range from 20 Hz to 20 kHz. Based on the Nyquist theorem, the recording rate should be at least 40 kHz.
path2=input('image file location :');%Taking the location of the encrypted image file
P=imread(path2);%gives a 650*600*3 array (This array consists of three m-by-n matrices (representing the red, green, and blue color planes) concatenated along the third dimension.)
L=size(P);%returns a row vector whose elements are the lengths of the corresponding dimensions of A. For example, if A is a 3-by-4 matrix, then size(A) returns the vector [3 4].
L=L(1); 
P=double(P)./255;%0 to 255 characters Use double-precision to store values greater than approximately 3.4 x 1038 or less than approximately -3.4 x 1038. For numbers that lie between these two limits, you can use either double- or single-precision, but single requires less memory.

%Step by step reverse process of encryption:-
ipos=P(1:L,1:L,:); 
ineg=P(1:L,L+1:2*L,:);

% for the positive values:-
a=round(ipos(:,:,1),2); % all the rows and caloumns of the red channel that are in the first page are rounded upto to 2 decimal places 
b=round(ipos(:,:,2),2); % all the rows and caloumns of the blue channel that are in the second page are rounded upto to 2 decimal places
c=round(ipos(:,:,3),2);% all the rows and caloumns of the green channel that are in the third page are rounded upto to 2 decimal places
%for the negative values:-
an=round(ineg(:,:,1),2);%For Red
bn=round(ineg(:,:,2),2);%For Blue
cn=round(ineg(:,:,3),2);%For Green

ipos=a+b+c; % adding all the positive value of red , blue and green channel
ineg=an+bn+cn; % adding all the negative value of red , blue and green channel
ipos=ipos';
ineg=-ineg';
final=ipos+ineg;% adding up the data obtained from the two images that is the matrices
final=reshape(final,1,L^2);% reshape the 'Final' matrix into a dimension of 1xL^2

loc=strcat(path2(1:strfind(path2,'.')-1),'.wav');%Specifying the location of the decrypted audio file where it should be saved
audiowrite(loc,final,Fs);% writes a matrix of audio data, final , with sample rate Fs to a file called loc.
fprintf('File successfully saved as %s\n', loc); 