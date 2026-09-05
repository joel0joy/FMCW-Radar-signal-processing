
%--------------------------------------------------------------------------

clear; addpath('./scripts');
maxfig  = 1;                                                                



solution_1

 c0      =  3*10^8   ;                                                      
 fc      =   24.125 *10^9    ;                                              
 BW      =   0.25 *10^9    ;                                                
 fS      =   1*10^6         ;                                               
 tChirp  =   190*10^-6     ;                                                
NChirps =    256            ;                                               

lChirp  =   190                ;                                            
dR      =   c0/(2*BW)             ;                                         
RMax    =  ( (fS/2) * c0 * tChirp ) / (2*BW)  ;                             

 NFFT   = 256;                                                              


initialize

files     = 55:56;                                                       
cycles    = 1:Ncycles;                                                      
threshold = -120;                                                           
                                                                            

RPwin     = hann(lChirp);
RvPwin    = hann(length(Rvec));

for file = files                                                            
 load(filelist{file})
 for cycle = cycles
  start = ((cycle-1)*((lChirp+1)*NChirps))+1;
  stop  = cycle*((lChirp+1)*NChirps);



solution_2

   IF1 = reshape(Data(start:stop,1),lChirp+1,[]);             IF1(1,:)=[];   
   IF2 = reshape(Data(start:stop,2),lChirp+1,[]);             IF2(1,:)=[];   
   IF3 = reshape(Data(start:stop,3),lChirp+1,[]);             IF3(1,:)=[];   
   IF4 = reshape(Data(start:stop,4),lChirp+1,[]);             IF4(1,:)=[]; 
   RPscl  = 7.9569E-8;                                                       
  RP1    = RPscl* fft(IF1 .* RPwin, NFFT, 1); RP1 = RP1(RMinIdx:NFFT/2,:);   
  RP2    = RPscl* fft(IF2 .* RPwin, NFFT, 1); RP2 = RP2(RMinIdx:NFFT/2,:);  
  RP3    = RPscl* fft(IF3 .* RPwin, NFFT, 1); RP3 = RP3(RMinIdx:NFFT/2,:);   
  RP4    = RPscl* fft(IF4 .* RPwin, NFFT, 1); RP4 = RP4(RMinIdx:NFFT/2,:);  

  
  % Velocity (double-sided spectra of Range Data)
  RvPscl = 1.04712e-2;                                                      
   RvP1   = RvPscl* fft(RP1 .*RvPwin, NFFT, 2);                             
   RvP2   = RvPscl* fft(RP2 .*RvPwin, NFFT, 2);                             
   RvP3   = RvPscl* fft(RP3 .*RvPwin, NFFT, 2);                             
   RvP4   = RvPscl* fft(RP4 .*RvPwin, NFFT, 2);                             

   
   %Mean Values of combined RD Values
   RvPlin = fftshift(abs(RvP1+RvP2+RvP3+RvP4)/4,2);                         
   RvP    =  20 *log10 (RvPlin)                   ;                          
   v_lo = 10;                                                                
   v_hi = 20;                                                                  
   xtract_target



  visualize
  if canceled; return; end
 end
end
datatip
close(closediag)



