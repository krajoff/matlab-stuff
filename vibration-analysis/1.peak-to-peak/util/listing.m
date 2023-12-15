function list = listing(path)

% return list of folders
    if exist(path) == 7
        listing = dir(path);
        listing = {listing.name};
        list{1} = listing(3:end);
    else
        error('����� � ������� �� ����������, ���������� ��������� � �������') 
    end   
% return list of files
    listing = dir(fullfile(path,list{1}{1}));
    listing = {listing.name};
    list{2} = listing(3:end);
    [~,list{3},~] = cellfun(@fileparts,list{2},'UniformOutput',false);
    list{3} = list{3}';
    for i = 2:length(list{1})
        listing = dir(fullfile(path,list{1}{i}));
        listing = {listing.name};
        if ~isempty(setdiff(list{2},listing(3:end)))
            error(['����� �������� ��������� ������ ������.\n',...
            '������ ������� ���������� ������ � ������: "%s" � "%s" \n'],list{1}{1},list{1}{i})
        end    
    end    
% modes recognition  
    pat.name = ["XXT","T","%n","���","U","o-load","�������","L","MW","���"];
    pat.mode = ["XXT","XXT","XXT","XX�","XX�","XX�","","","",""];
    pat.size = length(pat.name);  
    mode_num = length(list{3});
    for i = 1:pat.size
        inc = contains(list{3},pat.name(i));
        if sum(inc) > 0
            switch pat.mode(i)
                case 'XXT'
                    list{5}(1) = sum(inc);
                case 'XX�'        
                    list{5}(2) = sum(inc);
                case ''     
                    list{5}(3) = sum(inc);                     
            end
        end
        list{4}(inc) = pat.mode(i);
    end  
    for i = 1:mode_num
    	prc = regexp(list{3}(i),'\d*','match'); 
        if list{4}(i) == "XXT"
            prc = digital(prc,10);
            list{4}(i) = strcat(list{4}(i), [' ' num2str(prc) '%n_�']);     
        elseif list{4}(i) == "XX�"
            prc = digital(prc,10);
            list{4}(i) = strcat(list{4}(i), [' ' num2str(prc) '%U_�']);   
        else    
            prc = digital(prc,1);
            list{4}(i) = strcat([num2str(prc) '���']);  
        end    
    end    
end

function num = digital(cell, multiple)
	if ~isempty(cell)
        num=cellfun(@str2num, cell{1});
        if num < 15 && multiple > 1
            num = multiple*num;
        end    
	end   
end