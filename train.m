%% 상관관계
clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트\blood_pressure'
load('train_data.mat')

figure;
subplot(711);plot(SBP);xlabel('SBP');
subplot(712);plot(DBP);xlabel('DBP');
subplot(713);plot(feature_AREA);xlabel('AREA');
subplot(714);plot(feature_HR);xlabel('HR');
subplot(715);plot(feature_STT);xlabel('STT');
subplot(716);plot(feature_HEIGHT);xlabel('HEIGHT');
subplot(717);plot(feature_WIDTH);xlabel('WIDTH');

%area
[R,P] = corrcoef(SBP,feature_AREA);
figure;
plot(SBP,feature_AREA, 'o');xlabel('SBP');ylabel('feature AREA');

[R,P] = corrcoef(DBP,feature_AREA);
figure;
plot(DBP,feature_AREA, 'o');xlabel('DBP');ylabel('feature AREA');

%height
[R,P] = corrcoef(SBP,feature_HEIGHT);
figure;
plot(SBP,feature_HEIGHT, 'o');xlabel('SBP');ylabel('feature Height');

[R,P] = corrcoef(DBP,feature_HEIGHT);
figure;
plot(DBP,feature_HEIGHT, 'o');xlabel('DBP');ylabel('feature Height');

%hr
[R,P] = corrcoef(SBP,feature_HR);
figure;
plot(SBP,feature_HR, 'o');xlabel('SBP');ylabel('feature HR');

[R,P] = corrcoef(DBP,feature_HR);
figure;
plot(DBP,feature_HR, 'o');xlabel('DBP');ylabel('feature HR');

%width
[R,P] = corrcoef(SBP,feature_WIDTH);
figure;
plot(SBP,feature_WIDTH, 'o');xlabel('SBP');ylabel('feature Width');

[R,P] = corrcoef(DBP,feature_WIDTH);
figure;
plot(DBP,feature_WIDTH, 'o');xlabel('DBP');ylabel('feature Width');

%STT
[R,P] = corrcoef(SBP,feature_STT);
figure;
plot(SBP,feature_STT, 'o');xlabel('SBP');ylabel('feature STT');

[R,P] = corrcoef(DBP,feature_STT);
figure;
plot(DBP,feature_STT, 'o');xlabel('DBP');ylabel('feature STT');

%% 회귀
clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트\blood_pressure'
load('train_data.mat')
%% height
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_HEIGHT)) feature_HEIGHT]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_HEIGHT;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_HEIGHT)) feature_HEIGHT]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_HEIGHT;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% width
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_WIDTH)) feature_WIDTH]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_WIDTH;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_WIDTH)) feature_WIDTH]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_WIDTH;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% stt
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_STT)) feature_STT]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_STT;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_STT)) feature_STT]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_STT;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;



%% hr
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_HR)) feature_HR]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_HR;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_HR)) feature_HR]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_HR;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% width +height
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_WIDTH)) feature_WIDTH feature_HEIGHT]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_WIDTH+weights_DBP(3)*feature_HEIGHT;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_WIDTH)) feature_WIDTH feature_HEIGHT]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_WIDTH+weights_SBP(3)*feature_HEIGHT;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% stt+hr
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_STT)) feature_STT feature_HR]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_STT+weights_DBP(3)*feature_HR;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_STT)) feature_STT feature_HR]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_STT+weights_SBP(3)*feature_HR;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

save('weight','weights_DBP','weights_SBP');
%% width +height +hr
% dbp
weights_DBP =  regress(DBP, [ones(size(feature_WIDTH)) feature_WIDTH feature_HEIGHT feature_HR]);
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*feature_WIDTH+weights_DBP(3)*feature_HEIGHT+weights_DBP(4)*feature_HR;

err = mean(abs(DBP-Estimated_DBP));

[R,P] =corrcoef(DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

% sbp
weights_SBP =  regress(SBP, [ones(size(feature_WIDTH)) feature_WIDTH feature_HEIGHT feature_HR]);
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*feature_WIDTH+weights_SBP(3)*feature_HEIGHT+weights_SBP(4)*feature_HR;

err = mean(abs(SBP-Estimated_SBP));

[R,P] =corrcoef(SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

save('weight','weights_DBP','weights_SBP');