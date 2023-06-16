function BT = join2table(TCell)
[~, columns] = size(TCell);
[modes, ~] = size(TCell{1});
%BT = table('Size', [2*rows columns]);
BT = table();
    for i = 1:modes
        for j = 1:columns
            BT = [BT; TCell{j}(i,:)];
        end
    end
end