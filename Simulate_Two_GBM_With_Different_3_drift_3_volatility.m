drift=[0,0,0];
sigma0=[0.05,0.01,0.03];
sigma1=[0.05,0.01,0.03];


%%simulate first signal
period1=1000;
gbm1=gbm(drift(1),sigma0(1),'StartState',100);
dt=1;
period=period1;
[s1,t1]=simulate(gbm1,period,'DeltaTime',dt);
period=period1;
gbm2=gbm(drift(2),sigma0(2),'StartState',s1(end-1));
[s2,t2]=simulate(gbm2,period,'DeltaTime',dt);
period=period1;
gbm3=gbm(drift(3),sigma0(3),'StartState',s2(end-2));
[s3,t3]=simulate(gbm3,period,'DeltaTime',dt);
A=[[s1];[s2];[s3]];
f1=figure;
f2=figure;
figure(f1);
plot(A);


%%simulate second signal
period1=1000;
gbm01=gbm(drift(1),sigma1(1),'StartState',100);
dt=1;
period=1100;
[s1,t1]=simulate(gbm01,period,'DeltaTime',dt);
period=1000;
gbm02=gbm(drift(2),sigma1(2),'StartState',s1(end-1));
[s2,t2]=simulate(gbm02,period,'DeltaTime',dt);
period=900;
gbm03=gbm(drift(3),sigma1(3),'StartState',s2(end-2));
[s3,t3]=simulate(gbm03,period,'DeltaTime',dt);
B=[[s1];[s2];[s3]];
figure;
plot(B);

%%use modwt wavelet process first signal and plot
wA=modwt(A);
wA = modwtmra(wA);
figure;
for i=1:12
    subplot(13,1,i+1)
    plot(wA(i,:));
end


%%use modwt wavelet process first signal and plot
mB=modwt(B);
mB = modwtmra(mB);
figure;
for i=1:12
    
    subplot(13,1,i+1)
    plot(mB(i,:));
end

%%plot 2nd coefficient of modwt
x1=wA(2,:);
y1=mB(2,:);
figure
subplot(2,1,1)
plot(x1);
subplot(2,1,2)
plot(y1);

%%plot 3rd coefficient of modwt
x=wA(3,:);
y=mB(3,:);
figure
subplot(2,1,1)
plot(x);
subplot(2,1,2)
plot(y);




%%calculate the change point of the wavelet
[pts_Opt,kopt,t_est] = wvarchg(wA(3,:));
[pts_Opt1,kopt1,t_est1] = wvarchg(mB(3,:));
