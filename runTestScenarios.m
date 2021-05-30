%This script runs the testing framework
setPath

testFilesDir='test_scenarios/';

files=dir(testFilesDir);

for cDir=1:length(files)
    if ~files(cDir).isdir
        if strcmp(files(cDir).name(end-1:end),'.m')
            fprintf('running simulator for %s: ',files(cDir).name)
            
            overalMismatch=0;
            
            %run the test scenario script which will populated some
            %structures
            eval(files(cDir).name(1:end-2))
            
            %run the simulator
            outStruct=runSim(inStruct);

            %comparison with fields in refStruct:
            %logic is that for some fields in outStruct there exists a
            %field with the same name in refStruct.
            %Such a field is a structure with two fields value and epsilon. This constructs
            %the necessary values required for a comparison. Anything more
            %complicated must be built using these two elements.
            
            %comparison between outStruct and refStruct
            refFields=fieldnames(refStruct);
            for kField=1:length(refFields)
               if isfield(outStruct,refFields{kField})
                   if any(abs(outStruct.(refFields{kField}) - ...
                           refStruct.(refFields{kField}).value)>=refStruct.(refFields{kField}).epsilon)
                       %mismatch
                       overalMismatch=1;
                       fprintf('\n \t mismatch on refStruct.%s\n',refFields{kField})
                   end
               end
            end
            if ~overalMismatch
                fprintf(' PASS \n')
            end
        end
    end
end
