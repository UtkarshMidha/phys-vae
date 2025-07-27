clearvars;

c = 1;
for i = 1:50
    load(sprintf('./Subject%d.mat', i));
    for j = 1:numel(s.Data)
        if ~strcmp(s.Data(j).Task, 'Walking')
            continue;
        end

        data_all(:,:,c) = s.Data(j).Ang([4,7,10],:) * pi / 180;

        if strcmp(s.Data(j).Foot, 'RX')
            foot(c) = 0;
        else
            foot(c) = 1;
        end
        speed(c) = s.Data(j).speed;
        stride_length(c) = s.Data(j).strideLength;
        step_width(c) = s.Data(j).stepWidth;
        cadence(c) = s.Data(j).cadence;

        fprintf('%d\n', c);
        c = c + 1;
    end
end

prop_all = [foot(:), speed(:), stride_length(:), step_width(:), cadence(:)];

rng(1234567890);
idx = randperm(size(prop_all, 1));

tr_size = 400;
va_size = 100;

range = idx(1:tr_size);
data = permute(data_all(:,:,range), [3,1,2]);
save('data_train.mat', 'data');
dlmwrite('prop_train.txt', prop_all(range,:), 'delimiter', ' ');

range = idx(tr_size+1:tr_size+va_size);
data = permute(data_all(:,:,range), [3,1,2]);
save('data_valid.mat', 'data');
dlmwrite('prop_valid.txt', prop_all(range,:), 'delimiter', ' ');

range = idx(tr_size+va_size+1:end);
data = permute(data_all(:,:,range), [3,1,2]);
save('data_test.mat', 'data');
dlmwrite('prop_test.txt', prop_all(range,:), 'delimiter', ' ');
