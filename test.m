clear all; close all; clc;

cd 'E:\대학원\대학원 수업\2021-1 데이터마이닝\기말 프로젝트\blood_pressure'
load('test_data.mat')
load('weight.mat')
%% weight+height+hr
%dbp
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*TS_feature_WIDTH+weights_DBP(3)*TS_feature_HEIGHT+weights_DBP(4)*TS_feature_HR;

err = mean(abs(TS_DBP-Estimated_DBP));
[R,P] =corrcoef(TS_DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,TS_DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%sbp
Estimated_SBP = weights_SBP(1)+weights_SBP(2)*TS_feature_WIDTH+weights_SBP(3)*TS_feature_HEIGHT+weights_SBP(4)*TS_feature_HR;

err = mean(abs(TS_SBP-Estimated_SBP));
[R,P] =corrcoef(TS_SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,TS_SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% stt+hr
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*TS_feature_STT+weights_DBP(3)*TS_feature_HR;

err = mean(abs(TS_DBP-Estimated_DBP));
[R,P] =corrcoef(TS_DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,TS_DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

Estimated_SBP = weights_SBP(1)+weights_SBP(2)*TS_feature_STT+weights_SBP(3)*TS_feature_HR;

err = mean(abs(TS_SBP-Estimated_SBP));
[R,P] =corrcoef(TS_SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,TS_SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

%% stt
Estimated_DBP = weights_DBP(1)+weights_DBP(2)*TS_feature_STT;

err = mean(abs(TS_DBP-Estimated_DBP));
[R,P] =corrcoef(TS_DBP,Estimated_DBP);

figure;   
plot(Estimated_DBP,TS_DBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated DBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference DBP(mmHg)','fontsize',13,'fontweight','b');

x=55:1/1000:100;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;

Estimated_SBP = weights_SBP(1)+weights_SBP(2)*TS_feature_STT;

err = mean(abs(TS_SBP-Estimated_SBP));
[R,P] =corrcoef(TS_SBP,Estimated_SBP);

figure;   
plot(Estimated_SBP,TS_SBP,'rx','LineWidth',3);  hold on;
set(gca,'fontsize',13,'fontweight','b'); xlabel('Estimated SBP(mmHg)','fontsize',13,'fontweight','b'); ylabel('Reference SBP(mmHg)','fontsize',13,'fontweight','b');

x=100:1/1000:220;
y =x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 10,'b--','LineWidth',2); hold on;plot(x, y - 10,'b--','LineWidth',2); hold on;