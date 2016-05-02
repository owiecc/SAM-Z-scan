function [ firstInterfaceNoOutliers ] = removeOutliers( firstInterface )

% subplot(2,1,1); imagesc(firstInterface)

nanmedian = @(x) median(x(~isnan(x)));
mad = @(x) nanmedian(abs(x-nanmedian(x)));

x0 = firstInterface(:);
hh = abs(x0-nanmedian(x0))./mad(x0);
hh(hh>3) = NaN;
hh(hh<=3) = 1;
masknan = reshape(hh,250,250);


% subplot(2,1,2); imagesc(masknan.*firstInterface);
firstInterfaceNoOutliers = masknan.*firstInterface;
end