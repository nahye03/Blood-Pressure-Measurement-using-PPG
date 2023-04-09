%%
clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트'

load bp_related\valsalva1_data.mat

figure;
% subplot(311); plot(ECG); axis tight; %심전도
subplot(211); plot(PPG); axis tight; %ppg
subplot(212); plot(BP*100); axis tight; %혈압 

data1(:,1) =ECG(137939:160000);
data1(:,2) =PPG(137939:160000);
data1(:,3) =BP(137939:160000)*100;

x=1/fs:1/fs:length(data1)/fs;

figure;
% subplot(311); plot(data1(:,1)); axis tight; %심전도
subplot(211); plot(data1(:,2)); axis tight; %ppg
subplot(212); plot(data1(:,3)); axis tight; %혈압 

figure;
plot(data1(9114:11053,2)); 
%%
%SBP 구하기
bp = data1(:,3);
[b,a] = butter(5,40/(fs/2),'low');
f_bp = filtfilt(b, a, bp);
% figure;
% plot(bp);hold on;
% plot(x, f_dp);hold on;

dif_bp = diff(f_bp); 
% figure;
% plot(x, f_dp); hold on; plot(x(1:end-1), dif_bp); axis tight; xlabel('time'); ylabel('ampl');

%절대값
abs_bp = abs(dif_bp);

% figure;
% plot(x, f_dp); hold on; plot(x(1:end-1), dif_bp);hold on; plot(x(1:end-1), abs_bp); axis tight; xlabel('time'); ylabel('ampl');

%이동 평균
avg_bp = smooth(abs_bp, 0.3*fs, 'moving');
avg_bp = smooth(avg_bp, 0.3*fs, 'moving'); 
% figure;
% subplot(211);plot(x, bp);axis tight;
% subplot(212);plot(x(1:end-1), avg_bp);axis tight; xlabel('time'); ylabel('ampl');

%피크 찾기
[s_pv, s_pi] = findpeaks(avg_bp);

% figure;
% plot(x, f_dp);hold on;
% plot(x(1:end-1), avg_bp);hold on;plot(s_pi./Fs, s_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');

% figure;
% subplot(211);plot(x, f_dp);axis tight;
% subplot(212);plot(x(1:end-1), avg_bp);hold on;plot(s_pi./Fs, s_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');


%최종 피크 찾기
sbp_peak = [];
for k=2:1:length(s_pi)-2 %앞의 데이터가 없을 수 있으니 안정성을 위해 앞부분 조금 자름
    tmp = f_bp(s_pi(k)-round(fs/10):s_pi(k)+round(fs/50)); %앞에서 찾은 peak에서 그 앞에 1/20초 정도를 잘라서
    [ev,ei] = findpeaks(tmp); %그 앞에서 peak 찾기
    
    sbp_peak = [sbp_peak; ei+s_pi(k) - round(fs/10)-1];
end
sbp_peak = sbp_peak(f_bp(sbp_peak)>100);

figure;
plot(x, bp); hold on; plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;

sbp =bp(sbp_peak);
figure;
plot(sbp);

%%
%DBP 구하기
bp = data1(:,3);
[b,a] = butter(5,40/(fs/2),'low');
f_bp = filtfilt(b, a, bp);
% figure;
% plot(x, bp);hold on;
% plot(x, f_bp);hold on;

f_bp = -f_bp;
% figure;
% plot(x, bp);hold on;
% plot(x, f_bp);hold on;

dif_bp = diff(f_bp); 
% figure;
% plot(x, f_bp); hold on; plot(x(1:end-1), dif_bp); axis tight; xlabel('time'); ylabel('ampl');

%절대값
abs_bp = abs(dif_bp);
% 
% figure;
% plot(x, f_bp); hold on; plot(x(1:end-1), dif_bp);hold on; plot(x(1:end-1), abs_bp); axis tight; xlabel('time'); ylabel('ampl');

%이동 평균
avg_bp = smooth(abs_bp, 0.3*fs, 'moving');
avg_bp = smooth(avg_bp, 0.3*fs, 'moving'); 
% figure;
% subplot(211);plot(x, f_bp);axis tight;
% subplot(212);plot(x(1:end-1), avg_bp);axis tight; xlabel('time'); ylabel('ampl');

%피크 찾기
[d_pv, d_pi] = findpeaks(avg_bp);

% figure;
% plot(x, f_bp);hold on;
% plot(x(1:end-1), avg_bp);hold on;plot(d_pi./Fs, d_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');
% 
% figure;
% subplot(211);plot(x, f_bp);axis tight;
% subplot(212);plot(x(1:end-1), avg_bp);hold on;plot(d_pi./Fs, d_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');


%최종 피크 찾기
dbp_peak = [];
for k=2:1:length(d_pi)-2 %앞의 데이터가 없을 수 있으니 안정성을 위해 앞부분 조금 자름
    tmp = f_bp(d_pi(k)-round(fs/10):d_pi(k)); %앞에서 찾은 peak에서 그 앞에 1/20초 정도를 잘라서
    [ev,ei] = findpeaks(tmp); %그 앞에서 peak 찾기
    
    dbp_peak = [dbp_peak; ei+d_pi(k) - round(fs/10)-1];
end

figure;
plot(x, f_bp); hold on; plot(dbp_peak./fs,f_bp(dbp_peak), 'ro');axis tight;

dbp =bp(dbp_peak);
figure;
plot(dbp);

%sbp, dbp
figure;
plot(x, bp); hold on; plot(dbp_peak./fs,bp(dbp_peak), 'bo');axis tight;
plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;
%%
%ppg peak 찾기
ppg = data1(:,2);

[b,a] = butter(5, 30/(fs/2),'low');
p_ppg = filtfilt(b, a, ppg);

[p_pv, p_pi] = findpeaks(p_ppg);
p_pv = ppg(p_pi);

% figure;
% plot(x, ppg);hold on;
% plot(x, p_ppg);hold on;plot(p_pi./Fs, p_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');

%ppg valley 찾기
v_avg_peak = -p_ppg;
[v_pv, v_pi] = findpeaks(v_avg_peak);
v_pv = ppg(v_pi);
% figure;
% plot(x, ppg);hold on;
% plot(v_pi./Fs, -v_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');

%ppg peak valley 보기
figure;
plot(x, ppg);hold on;
plot(v_pi./fs, v_pv, 'bo'); axis tight; 
plot(p_pi./fs, p_pv, 'ro'); axis tight;
xlabel('time');ylabel('ampl');

%%
%PTT 구하기
width = p_pi - v_pi;
feature_WIDRH = width(2:end-1);
height = p_pv - v_pv;
feature_HEIGHT = height(2:end-1);
feature_STT=[];
for i=1:1:length(width)
    feature_STT = [feature_STT;width(i)/height(i)];
end
feature_STT = feature_STT(2:end-1);

figure;
subplot(311);plot(x, ppg);hold on;plot(v_pi./fs, v_pv, 'bo'); plot(p_pi./fs, p_pv, 'ro'); axis tight;
subplot(312);plot(x, bp); hold on; plot(dbp_peak./fs,bp(dbp_peak), 'bo');plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;
subplot(313);plot(feature_HEIGHT);

% 
% figure;
% plot(feature_STT);
% 
% figure;
% plot(feature_WIDRH);
% 
% figure;
% plot(feature_HEIGHT);

%ppg, bp 같이 보기
figure;
subplot(311);plot(x, ppg);hold on;plot(v_pi./fs, v_pv, 'bo'); plot(p_pi./fs, p_pv, 'ro'); axis tight;
subplot(312);plot(x, bp); hold on; plot(dbp_peak./fs,bp(dbp_peak), 'bo');plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;
subplot(313);plot(feature_STT);

%%
% HR
rri = diff(p_pi./fs);
rri = rri(2:end);
figure;
plot(rri);

feature_HR = 60./rri;
figure;
subplot(311);plot(x, ppg);hold on;plot(v_pi./fs, v_pv, 'bo'); plot(p_pi./fs, p_pv, 'ro'); axis tight;
subplot(312);plot(x, bp); hold on; plot(dbp_peak./fs,bp(dbp_peak), 'bo');plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;
subplot(313);plot(feature_HR);

%% 
% 넓이

figure;
plot(ppg);hold on;
plot(v_pi, -v_pv, 'bo'); axis tight; 
plot(p_pi, p_pv, 'ro'); axis tight;

feature_AREA=[];
for i=2:1:length(v_pi)-1
    h = ppg(v_pi(i):v_pi(i+1));
    w=1/fs:1/fs:length(h)/fs;
    feature_AREA = [feature_AREA;trapz(w,h)];
end

figure;
subplot(311);plot(x, ppg);hold on;plot(v_pi./fs, v_pv, 'bo'); plot(p_pi./fs, p_pv, 'ro'); axis tight;
subplot(312);plot(x, bp); hold on; plot(dbp_peak./fs,bp(dbp_peak), 'bo');plot(sbp_peak./fs,bp(sbp_peak), 'ro');axis tight;
subplot(313);plot(feature_AREA);

figure;
subplot(211);
plot(ppg);hold on;
plot(v_pi, v_pv, 'bo'); axis tight; 
plot(p_pi, p_pv, 'ro'); axis tight;
subplot(212);plot(feature_AREA); axis tight;
%%
%ecg
ecg= data1(:,1);
% figure;
% plot(ecg);

[b,a] = butter(5, 30/(fs/2),'low');
fecg = filtfilt(b, a, ecg);

[b2,a2] = butter(5, 3/(fs/2),'high'); %t peak가 r peak 보다 커서 천천히 변하는 t를 없애기 위해 저대역을 많이 날림
fecg = filtfilt(b2, a2, fecg);

% figure;
% plot(ecg);hold on;plot(fecg);

dif_ecg = diff(fecg); 
% figure;
% plot(x, fecg); hold on; plot(x(1:end-1), dif_ecg); axis tight; xlabel('time'); ylabel('ampl');

%절대값
abs_ecg = abs(dif_ecg);
% figure;
% plot(x, fecg); hold on; plot(x(1:end-1), dif_ecg);hold on; plot(x(1:end-1), abs_ecg); axis tight; xlabel('time'); ylabel('ampl');

avg_ecg = smooth(abs_ecg, 0.3*fs, 'moving');
avg_ecg = smooth(avg_ecg, 0.3*fs, 'moving'); % 경험적으로 두번적용하면 더 부드럽게 나옴
avg_ecg = smooth(avg_ecg, 0.3*fs, 'moving');

% figure;
% subplot(211);plot(x, ecg);axis tight;
% subplot(212);plot(x(1:end-1), avg_ecg);axis tight; xlabel('time'); ylabel('ampl');

%피크 찾기
[e_pv, e_pi] = findpeaks(avg_ecg);
% 
% figure;
% plot(x, fecg);hold on;
% plot(x(1:end-1), avg_ecg);hold on;plot(e_pi./fs, e_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');
% 
% figure;
% subplot(211);plot(fecg);axis tight;
% subplot(212);plot(avg_ecg);hold on;plot(e_pi, e_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');

ecg_peak = [];
for k=3:1:length(e_pi) %앞의 데이터가 없을 수 있으니 안정성을 위해 앞부분 조금 자름
    tmp = fecg(e_pi(k)-round(fs/5):e_pi(k)); %앞에서 찾은 peak에서 그 앞에 1/20초 정도를 잘라서
    [ev,ei] = findpeaks(tmp); %그 앞에서 peak 찾기
    
    ecg_peak = [ecg_peak; ei+e_pi(k) - round(fs/5)-1];
end
ecg_peak = ecg_peak(fecg(ecg_peak)>0.3);

figure;
plot(x, ecg); hold on; plot(ecg_peak./fs,ecg(ecg_peak), 'ro');axis tight;

%%
%저장
SBP1 = sbp;
DBP1 = dbp;
feature_HR1 = feature_HR;
feature_AREA1 = feature_AREA;
feature_HEIGHT1 = feature_HEIGHT;
feature_WIDRH1 = feature_WIDRH;
feature_STT1 = feature_STT;

save('blood_pressure\tr_1','SBP1','DBP1','feature_HR1','feature_AREA1','feature_HEIGHT1','feature_WIDRH1','feature_STT1');
