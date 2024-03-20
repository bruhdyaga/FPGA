function plot_matrix(ha, M )

KRep = 3;
MSize = size(M,1);
MRep = nan(KRep*MSize);
XTicksV = nan(1, KRep*MSize);
for i = 1:MSize
    XTicksV(KRep*i-KRep+1:KRep*i) = i-1:1/(KRep-1):i;
    for j = 1:MSize
        MRep(KRep*i-KRep+1:KRep*i, KRep*j-KRep+1:KRep*j) = M(i, j);
    end
end
[XTicksM, YTicksM] = meshgrid(XTicksV, XTicksV);

h = surf(YTicksM, XTicksM, MRep);
set(h, 'EdgeColor', 'none');
axis(ha, 'equal')
set(ha, 'YDir', 'reverse');
view(ha, -90, -90)
xlabel(ha, 'm');
ylabel(ha, 'n');
ticks = 0:1:MSize;
labels = ticks + 0.0;
labels = num2cell(labels);
for i = 1:length(labels)
    if (labels{i} ~= round(labels{i}))
        labels{i} = '';
    else
        labels{i} = num2str(labels{i});
    end
end
labels{1} = '';
set(ha, 'XTick', ticks);
set(ha, 'XTickLabelMode', 'manual');
set(ha, 'XTickLabel', labels);
set(ha, 'YTick', ticks);
set(ha, 'YTickLabelMode', 'manual');
set(ha, 'YTickLabel', labels);
colormap(ha, jet);
colorbar;

end

