%%
clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트'

load bp_related\valsalva5_data.mat

figure;
subplot(311); plot(ECG); axis tight; %심전도
subplot(312); plot(PPG); axis tight; %ppg
subplot(313); plot(BP); axis tight; %혈압 

st=98808;
nd=122724;
data(:,1) =ECG(st:nd);
data(:,2) =PPG(st:nd);
data(:,3) =BP(st:nd)*100;

x=1/fs:1/fs:length(data)/fs;

figure;
subplot(311); plot(data(:,1)); axis tight; %심전도
subplot(312); plot(data(:,2)); axis tight; %ppg
subplot(313); plot(data(:,3)); axis tight; %혈압 
%%
%SBP 구하기
bp = data(:,3);

sbp =[237,1263,2248,3022,4042,5157,6295,7378,8487,9590,10674,11790,12920,14004,15092,16168,17273,18375,19468,20503,21563,22559];
sbp=bp(sbp');

figure;
plot(bp);axis tight;hold on;plot(sbp, bp(sbp),'ro');

%%
%DBP 구하기
dbp=[75,1108,2094,2874,3896,5010,6150,7244,8354,9454,10540,11664,12790,13876,14970,16046,17146,18246,19333,20388,21437,22425];
dbp=bp(dbp');

figure;
plot(bp);hold on;plot(dbp, bp(dbp),'ro');

%sbp, dbp
figure;
plot(x, bp); hold on; plot(dbp./fs,bp(dbp), 'bo');axis tight;
plot(sbp./fs,bp(sbp), 'ro');axis tight;
%%
%ppg peak 찾기
ppg = data(:,2);

[b,a] = butter(5, 25/(fs/2),'low');
p_ppg = filtfilt(b, a, ppg);

% figure;
% plot(p_ppg);

[p_pv, p_pi] = findpeaks(p_ppg);

p_pi = p_pi(p_pi~=28 & p_pi~=545& p_pi~=610& p_pi~=3301& p_pi~=5078& p_pi~=5545& p_pi~=8404 & p_pi~=8881 & p_pi~=9974 & p_pi~=11782 & p_pi~=17239 & p_pi~=21398 );
p_pv=ppg(p_pi);

% 
% figure;
% plot(x, ppg);hold on;
% plot(x, p_ppg);hold on;plot(p_pi./fs, p_pv, 'ro'); axis tight; xlabel('time');ylabel('ampl');

%ppg valley 찾기
v_avg_peak = -p_ppg;
[v_pv, v_pi] = findpeaks(v_avg_peak);

v_pi=v_pi(v_pi~=486 & v_pi~=599& v_pi~=3266& v_pi~=5074 & v_pi~=5539& v_pi~=8392& v_pi~=8843& v_pi~=9945 & v_pi~=11764& v_pi~=17231&v_pi~=21345);
v_pv=ppg(v_pi);

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
p_pi_=p_pi(1:end-1);
v_pi_ = v_pi(1:end-1);
p_pv_=p_pv(1:end-1);
v_pv_ = v_pv(1:end-1);

width = p_pi_ - v_pi_;
feature_WIDRH = width;
height = p_pv_ - v_pv_;
feature_HEIGHT = height;
feature_STT=[];
for i=1:1:length(width)
    feature_STT = [feature_STT;width(i)/height(i)];
end

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
subplot(312);plot(x, bp); hold on; plot(dbp./fs,bp(dbp), 'bo');plot(sbp./fs,bp(sbp), 'ro');axis tight;
subplot(313);plot(feature_STT);

%%
% HR
rri = diff(p_pi./fs);

figure;
plot(rri);

feature_HR = 60./rri;
figure;
plot(feature_HR);

%% 
% 넓이

figure;
plot(ppg);hold on;
plot(v_pi, -v_pv, 'bo'); axis tight; 
plot(p_pi, p_pv, 'ro'); axis tight;

feature_AREA=[];
for i=1:1:length(v_pi)-1
    h = ppg(v_pi(i):v_pi(i+1));
    w=1/fs:1/fs:length(h)/fs;
    feature_AREA = [feature_AREA;trapz(w,h)];
end

figure;
subplot(211);
plot(ppg);hold on;
plot(v_pi, v_pv, 'bo'); axis tight; 
plot(p_pi, p_pv, 'ro'); axis tight;
subplot(212);plot(feature_AREA); axis tight;
%%
%ecg
ecg= data(:,1);
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
SBP5 = sbp;
DBP5 = dbp;
feature_HR5 = feature_HR;
feature_AREA5 = feature_AREA;
feature_HEIGHT5 = feature_HEIGHT;
feature_WIDRH5 = feature_WIDRH;
feature_STT5 = feature_STT;

save('blood_pressure\tr_5','SBP5','DBP5','feature_HR5','feature_AREA5','feature_HEIGHT5','feature_WIDRH5','feature_STT5');
