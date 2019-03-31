close all;
drift=[0.001,0.001,0.001,0.001,0.001,0.001];
sigma0=[0.02,0.05,0.03,0.01,0.04,0.02];
sigma1=[0.05,0.05,0.01,0.02,0.01,0.04];


%%simulate first signal
period1=100;
gbm1=gbm(drift(1),sigma0(1),'StartState',100);
dt=1;

period=period1;
[s1,t1]=simulate(gbm1,period,'DeltaTime',dt);
period=period1;
gbm2=gbm(drift(2),sigma0(2),'StartState',s1(end));
[s2,t2]=simulate(gbm2,period,'DeltaTime',dt);
period=period1;
gbm3=gbm(drift(3),sigma0(3),'StartState',s2(end));
[s3,t3]=simulate(gbm3,period,'DeltaTime',dt);
period=period1;
gbm4=gbm(drift(4),sigma0(4),'StartState',s3(end));
[s4,t4]=simulate(gbm4,period,'DeltaTime',dt);
period=period1;
gbm5=gbm(drift(5),sigma0(5),'StartState',s4(end));
[s5,t5]=simulate(gbm5,period,'DeltaTime',dt);
A=[[s1];[s2];[s3];[s4];[s5]];
f1=figure;
figure(f1);
A=A(1:500);
plot(A);
title('The Whole Process of the Artifical Signal')
xlabel('Time')
ylabel('First-Order Difference of the Log Return ')


AP=diff(log(A));
figure;
plot(AP)
title('Volatility of the Artificial Signal')
xlabel('Time')
ylabel('First-Order Difference of the Log Return ')

%%another method to gbm2

period1=1;%%lead-lag term relation
gbm1=gbm(drift(1),sigma0(1),'StartState',100);
dt=1;
period=period1;
[s01,t01]=simulate(gbm1,period,'DeltaTime',dt);
multi=100/s01(end);
s01=multi*s01;
B=[[s01];[s1];[s2];[s3];[s4];[s5]];
B=B(1:500);
BP=diff(log(B));

figure;
plot(B);
figure;
plot(BP)
title('Volatility of the Artificial Signal with Lag 10')
xlabel('Time')
ylabel('First-Order Difference of the Log Return ')

figure;
subplot(2,1,1)
plot(AP);
subplot(2,1,2)
plot(BP);




wa=modwt(AP);
mb=modwt(BP);
figure;
modwtcorr(wa,mb);

[xc,lags] = xcorr(wa(5,:),mb(5,:));
[~,I] = max(abs(xc));
figure
stem(lags,xc,'filled')
legend(sprintf('Maximum at lag %d',lags(I)))
title(' Cross-Correlation Sequence')
xlabel('Time')
ylabel('Cross-Correlation Coefficient')

[xc,~,lags] = modwtxcorr(wa,mb,'fk14');
lev = 5;
zerolag = floor(numel(xc{lev})/2+1);
tlag = lags{lev}(zerolag-100:zerolag+100);
figure
plot(tlag,xc{lev}(zerolag-100:zerolag+100))
title('Wavelet Cross-Correlation Sequence (level 3)')
xlabel('Time')
ylabel('Cross-Correlation Coefficient')
