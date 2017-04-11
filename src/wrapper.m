%%wrapper
%Asks the user for input to determine which script to run
dimensions=0;
choice='choice';
while dimensions<1||dimensions>2
    dimensions=input('Please enter the dimensions of the model (1 or 2):  ');
end
while ~strcmp(choice,'latices')&&~strcmp(choice,'magnetization')
    choice=input('choose the model (latices or magnetization):  ','s');
end
if dimensions==1
    if strcmp(choice,'latices')
        advancedlab_ising_1D_p;
    else
        advancedlab_ising_1D_mag;
    end
else
    if strcmp(choice,'latices')
        advancedlab_ising_2D;
    else
        advancedlab_ising_2D_energymagmagsusspehea
    end
end