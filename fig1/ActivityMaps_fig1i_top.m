function ActivityMaps(PF_loc_WT,PF_loc_RTT,saving)

WT_UnSortedStack = Return_UnSortedStack(PF_loc_WT);
RTT_UnSortedStack = Return_UnSortedStack(PF_loc_RTT);

cmap = sky;
cmap_lim = [-.1 1];
make_StackFig(WT_UnSortedStack,cmap,cmap_lim,1,saving)
if saving == 1
    save('fig1I_WT.mat','WT_UnSortedStack');
end

cmap = flipud(hot);
cmap_lim = [-.05 1.75];
make_StackFig(RTT_UnSortedStack,cmap,cmap_lim,2,saving)
if saving == 1
    save('fig1I_RTT.mat','RTT_UnSortedStack');
end

end
function make_StackFig(Array,cmap,cmap_lim,gt,saving)
figure;
imshow(Array,'InitialMagnification','fit')
daspect([1 273.93 2])
colormap(cmap);
clim(cmap_lim);
axis('on')
%yticks(0:size(Array,1)/5:size(Array,1)); % divided by 5 for 20%
yticks([1 size(Array,1)]);
set(gca,'LineWidth',2);
set(gca,'FontSize',12);
yticklabels([1 size(Array,1)]);
xlabel('Time (day)');
ylabel('CA1 cells');
xticks(1:7)
xtickangle(0)
%set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[]);
set(gca, 'Box', 'off');
set(gca, 'FontSize', 30);
set(gca, 'LineWidth',2);
set(gcf,'Position',[500 500 500 500]);

if gt == 1 && saving == 1
    print(gcf, 'fig1I_WT.pdf','-dpdf','-vector','-bestfit');
end

if gt == 2 && saving == 1
    print(gcf, 'fig1I_RTT.pdf','-dpdf','-vector','-bestfit');
end

end

function [Stack] = Return_UnSortedStack(PFloc)
PForNot = ~isnan(PFloc(:,3:9));
PF_number = nansum(PForNot,2);
Stack = [];
for i =7:-1:0
Stack = vertcat(Stack,PForNot(PF_number==i,:));
end
end