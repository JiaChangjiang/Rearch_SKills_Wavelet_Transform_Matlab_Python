%%use modwt wavelet process first signal and plot
wA=modwt(index,7);
wA_mra = modwtmra(wA);


%%use modwt wavelet process first signal and plot
mB=modwt(exchange,7);
mB_mra = modwtmra(mB);

%%plot 2nd coefficient of modwt
x1=wA(2,:);
y1=mB(2,:);
figure
subplot(2,1,1)
plot(x1);
subplot(2,1,2)
plot(y1);
title('2nd coefficient of modwt');
%%plot 3rd coefficient of modwt
x=wA(3,:);
y=mB(3,:);
figure
subplot(2,1,1)
plot(x);
subplot(2,1,2)
plot(y);
title('3rd coefficient of modwt');
