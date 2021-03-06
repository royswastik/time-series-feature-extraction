EO = extraction_methods;

fl_nms = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};
file_path = 'C:\MyStuff\ASU\Spring_2018\DM\Project\time-series-feature-extraction';
mkdir('features')
for i = 11:12
    %file_path_separator = '/';
    file_path_separator = '\';
    if i < 10
        idx = strcat('0',num2str(i));
    else
        idx = num2str(i)
    end
    dataFolder = strcat('Output',idx);
    userPath = strcat(file_path,file_path_separator);
    % if feature.csv is present before hand then delete 
    %delete(strcat(file_path,'features.csv'))
    featureFileName = strcat('features',num2str(idx),'.csv');
    disp(featureFileName)
    for fl_nm_ind = 1:length(fl_nms)
        fig_path = strcat(file_path,fl_nms(fl_nm_ind),file_path_separator);
        fl_nm = char(strcat('Data for Users\',dataFolder,file_path_separator,fl_nms(fl_nm_ind),'.csv'));
        fid = fopen(fl_nm, 'rt');

        datatypes = '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
        data = textscan(fid,datatypes,'headerlines', 1, 'delimiter', ',');
        fclose(fid); 
        height = length(data{1}) - 34 +1;

        for row = 1:34:height
        %     for row = 1:34:67
        alx =[];aly =[];alz =[];arx =[];ary =[];arz =[];
        glx =[];gly =[];glz =[];grx =[];gry =[];grz =[];
        orl =[];opl =[];oyl =[];orr =[];opr =[];oyr =[];
        emg0l = [];emg1l = [];emg2l = [];emg3l = [];emg4l = [];emg5l = [];emg6l = [];emg7l = [];
        emg0r = [];emg1r = [];emg2r = [];emg3r = [];emg4r = [];emg5r = [];emg6r = [];emg7r = [];
        for col = 1:46

        %             Gettings sensors values for each action
            alx = [alx data{col}(row,1)];aly = [aly data{col}(row+1,1)];alz = [alz data{col}(row+2,1)];
            arx = [arx data{col}(row+3,1)];ary = [ary data{col}(row+4,1)];arz = [arz data{col}(row+5,1)];

            emg0l = [emg0l data{col}(row+6,1)];emg1l = [emg1l data{col}(row+7,1)];emg2l = [emg2l data{col}(row+8,1)];
            emg3l = [emg3l data{col}(row+9,1)];emg4l = [emg4l data{col}(row+10,1)];emg5l = [emg5l data{col}(row+11,1)];
            emg6l = [emg6l data{col}(row+12,1)];emg7l = [emg7l data{col}(row+13,1)];

            emg0r = [emg0r data{col}(row+14,1)];emg1r = [emg1r data{col}(row+15,1)];emg2r = [emg2r data{col}(row+16,1)];
            emg3r = [emg3r data{col}(row+17,1)];emg4r = [emg4r data{col}(row+18,1)];emg5r = [emg5r data{col}(row+19,1)];
            emg6r = [emg6r data{col}(row+20,1)];emg7r = [emg7r data{col}(row+21,1)];

            glx = [glx data{col}(row+22,1)];gly = [gly data{col}(row+23,1)];glz = [glz data{col}(row+24,1)];
            grx = [grx data{col}(row+25,1)];gry = [gry data{col}(row+26,1)];grz = [grz data{col}(row+27,1)];

            orl = [orl data{col}(row+28,1)];opl = [opl data{col}(row+29,1)];oyl = [oyl data{col}(row+30,1)];
            orr = [orr data{col}(row+31,1)];opr = [opr data{col}(row+32,1)];oyr = [oyr data{col}(row+33,1)];
        end


        %         Setting features for classification task
        f_acc_l = [EO.maxFFT(alx(:,2:end)), EO.maxFFT(aly(:,2:end)), EO.maxFFT(alz(:,2:end))];
        f_acc_r = [EO.maxFFT(arx(:,2:end)) EO.maxFFT(ary(:,2:end)) EO.maxFFT(arz(:,2:end)) ...
            EO.waveform_length(arx(:,2:end)) EO.waveform_length(ary(:,2:end)) EO.waveform_length(arz(:,2:end)) ...
            EO.root_mean_square(arx(:,2:end)) EO.root_mean_square(ary(:,2:end)) EO.root_mean_square(arz(:,2:end)) ...
            EO.vector_mean(arx(:,2:end), ary(:,2:end), arz(:,2:end)) EO.vector_sd(arx(:,2:end), ary(:,2:end), arz(:,2:end)) ... 
            EO.mean_power_f(arx(:,2:end)) EO.mean_power_f(ary(:,2:end))  EO.mean_power_f(arz(:,2:end)) ...
            EO.sd_power_f(arx(:,2:end))  EO.sd_power_f(ary(:,2:end))  EO.sd_power_f(arz(:,2:end)) ...
            EO.energy_consumption(arx(:,2:end)) EO.energy_consumption(ary(:,2:end)) EO.energy_consumption(arz(:,2:end)) ...  
            EO.skew(arx(:,2:end)) EO.skew(ary(:,2:end)) EO.skew(arz(:,2:end))  ...
            EO.average_in_heading_direction(arx(:,2:end), ary(:,2:end), arz(:,2:end))];
        f_emg_l = [EO.maxFFT(emg0l(:,2:end)) EO.maxFFT(emg1l(:,2:end)) EO.maxFFT(emg2l(:,2:end)) EO.maxFFT(emg3l(:,2:end)) EO.maxFFT(emg4l(:,2:end)) EO.maxFFT(emg5l(:,2:end)) EO.maxFFT(emg6l(:,2:end))];
        f_emg_r = [EO.maxFFT(emg0r(:,2:end)) EO.maxFFT(emg1r(:,2:end)) EO.maxFFT(emg2r(:,2:end)) EO.maxFFT(emg3r(:,2:end)) EO.maxFFT(emg4r(:,2:end)) EO.maxFFT(emg5r(:,2:end)) EO.maxFFT(emg6r(:,2:end))];
        f_gyro_l = [EO.maxFFT(glx(:,2:end)) EO.maxFFT(gly(:,2:end)) EO.maxFFT(glz(:,2:end))];
        f_gyro_r = [EO.maxFFT(grx(:,2:end)) EO.maxFFT(gry(:,2:end)) EO.maxFFT(grz(:,2:end)) ...
                EO.waveform_length(grx(:,2:end)) EO.waveform_length(gry(:,2:end)) EO.waveform_length(grz(:,2:end)) ...
                EO.root_mean_square(grx(:,2:end)) EO.root_mean_square(gry(:,2:end)) EO.root_mean_square(grz(:,2:end)) ...
                EO.vector_mean(grx(:,2:end), gry(:,2:end), grz(:,2:end)) EO.vector_sd(grx(:,2:end), gry(:,2:end), grz(:,2:end)) ...
                EO.mean_power_f(grx(:,2:end)) EO.mean_power_f(gry(:,2:end))  EO.mean_power_f(grz(:,2:end)) ...
                EO.sd_power_f(grx(:,2:end)) EO.sd_power_f(gry(:,2:end)) EO.sd_power_f(grz(:,2:end)) ...
                EO.energy_consumption(grx(:,2:end)) EO.energy_consumption(gry(:,2:end)) EO.energy_consumption(grz(:,2:end)) ...
                EO.skew(grx(:,2:end)) EO.skew(gry(:,2:end)) EO.skew(grz(:,2:end)) ...
                EO.average_in_heading_direction(grx(:,2:end), gry(:,2:end), grz(:,2:end))];
        f_or_l = [EO.maxFFT(orl(:,2:end)) EO.maxFFT(opl(:,2:end)) EO.maxFFT(oyl(:,2:end))];
        f_or_r = [EO.maxFFT(orr(:,2:end)) EO.maxFFT(opr(:,2:end)) EO.maxFFT(oyr(:,2:end))];
        f_label = [fl_nm_ind];

        feature_row = [f_acc_l,f_acc_r, f_emg_l, f_emg_r, f_gyro_l, f_gyro_r, f_or_l, f_or_r, f_label ];

        %Replacing NaN with zeros
        feature_row(isnan(feature_row))=0;
        
        feature_file = strcat(file_path,file_path_separator,'features',file_path_separator,featureFileName);
        dlmwrite(feature_file,feature_row,'-append');

    end
    end
end