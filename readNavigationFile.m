function [ sat, IODE, Crs, delta_n, m0, Cuc, e, Cus, sqrtA, Toe, Cic, OMEGA, Cis, i0, Crc, omega, OMEGADOT, iDOT, GPSweek, entry, T ] = readNavigationFile(navFile);%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here


%Initial variable values set
v = 0;
broadcastOrbit = 0;
entry = 0;
count = 0;

%Open text file for reading
fid=fopen(navFile);
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    
    %extract variables
    if v==1
        disp(tline)
        switch broadcastOrbit
            case 0
                %Defines that a new navigation entry has been recorded
                entry = entry + 1;
                sat(entry) = str2num(tline(1:2));
                %Epoc time entry
%                 if str2num(tline(3:5)) > 79;
%                     year(entry) = str2num(tline(3:5)) + 1900;
%                 else
%                     year(entry) = str2num(tline(3:5)) + 2000;
%                 end
%                 month(entry) = str2num(tline(6:8));
%                 day(entry) = str2num(tline(9:11));
%                 hour(entry) = str2num(tline(12:14));
%                 min(entry) = str2num(tline(15:17));
%                 second(entry) = str2num(tline(18:22));
                
                %Matlab time code (time past Epoch) This is by defult
                %measured in days, therefore the value is multiplied by
                %86400, to convert to seconds past the epoch.
                
%                 secondsPast1980(entry) = (datenum([year(entry) month(entry) day(entry) hour(entry) min(entry) second(entry)]) - datenum([1980 1 6 0 0 0])) * 86400;
                                      
%                 SVclockBias(entry) = str2num(tline(23:41));
%                 SVclockDrift(entry) = str2num(tline(42:60));
%                 SVclockDriftRate(entry) = str2num(tline(61:79));
            
            case 1    
                %Broadcast Orbit 1
                IODE(entry) = str2num(tline(4:22));
                Crs(entry) = str2num(tline(23:41));
                delta_n(entry) = str2num(tline(42:60));
                m0(entry) = str2num(tline(61:79));
                 
            case 2
                %Broadcast Orbit 2
                Cuc(entry) = str2num(tline(4:22));
                e(entry) = str2num(tline(23:41));
                Cus(entry) = str2num(tline(42:60));
                sqrtA(entry) = str2num(tline(61:79));
                
            case 3
                %Broadcast Orbit 3
                Toe(entry) = str2num(tline(4:22));
                Cic(entry) = str2num(tline(23:41));
                OMEGA(entry) = str2num(tline(42:60));
                Cis(entry) = str2num(tline(61:79));
              
            case 4
                %Broadcast Orbit 4
                i0(entry) = str2num(tline(4:22));
                Crc(entry) = str2num(tline(23:41));
                omega(entry) = str2num(tline(42:60));
                OMEGADOT(entry) = str2num(tline(61:79));
                
            case 5
                %Broadcast Orbit 5
                iDOT(entry) = str2num(tline(4:22));
%                 codesL2(entry) = str2num(tline(23:41));
                GPSweek(entry) = str2num(tline(42:60));
                               
            case 6
                %Broadcast Orbit 6
%                 SVaccuracy(entry) = str2num(tline(4:22));
%                 SVhealth(entry) = str2num(tline(23:41));
%                 TGD(entry) = str2num(tline(42:60));
%                 IODC(entry) = str2num(tline(61:79));
                
            case 7
                %Broadcast Orbit 7
%                 transTime(entry) = str2num(tline(4:22));
%                 unknownData(entry) = str2num(tline(23:41));
                
        end
                        
        broadcastOrbit = broadcastOrbit + 1;
        if broadcastOrbit > 7, broadcastOrbit = 0; end; %Resets the broadcast orbit number back to 0
            
    end
    
    if v==0;
        headerEnd = strtrim(tline);
        count=count+1
        if count == 5
            T = str2num(tline(42:50));
        end
        if headerEnd(1,1:13) == 'END OF HEADER';
            v=1;
        end
    end
       
end
fclose(fid);