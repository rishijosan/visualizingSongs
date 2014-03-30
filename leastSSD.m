function [ index ] = leastSSD( histCell , compHist )

len = length(histCell);

for i=1:len
    ssd(i) = sum ((histCell{i}(:) - compHist(:)).^2);
end

index = find(ssd == min(ssd(:)));

end

