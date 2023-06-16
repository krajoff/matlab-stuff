function yesOrNo = messageButton(extStr)
    if extStr 
        answer = questdlg(['Workspace already has opt-structure. ', ...
            'Remove the structure and recalculate everything ' , ...
            'one more time?'], 'Struct file', 'Yes', 'No', 'No');
        switch answer
            case 'Yes'
                disp('Recalculating data')
                yesOrNo = true;
            case 'No'
                disp('Nothing was calculated')
                yesOrNo = false;
        end
    else
        yesOrNo = true;
    end  
end