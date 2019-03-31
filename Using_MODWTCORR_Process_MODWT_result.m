%%POST
figure;
for i=1:8
    subplot(9,1,i+1)
    plot(wa(i,:));
end
title('modwt of index')

figure;
for i=1:8
    
    subplot(9,1,i+1)
    plot(mB(i,:));
end
title('modwt of exchange rate')

close all;
wa=modwt(index,8);
mb=modwt(exchange,8);
figure;
modwtcorr(wa,mb);

[xc,lags] = xcorr(wa(1,:),mb(1,:));
[~,I] = max(abs(xc));
figure
stem(lags,xc,'filled')
legend(sprintf('Maximum at lag %d',lags(I)))
title('Sample Cross-Correlation Sequence')

[xc,~,lags] = modwtxcorr(wa,mb,'fk14');
lev = 3;
zerolag = floor(numel(xc{lev})/2+1);
tlag = lags{lev}(zerolag-3200:zerolag+3200);
figure
plot(tlag,xc{lev}(zerolag-3000:zerolag+3000))
title('Wavelet Cross-Correlation Sequence (level 3)')
xlabel('Time')
ylabel('Cross-Correlation Coefficient')