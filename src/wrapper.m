%%wrapper
%Asks the user for input to determine which script to run
dimensions=0;
choice='c';
while dimensions<1||dimensions>2
    dimensions=input('Please enter the dimensions of the model (1 or 2):  ');
end
while ~strcmp(choice,'m')&&~strcmp(choice,'l')
    choice=input('choose the model ((l)atices or (m)agnetization):  ','s');
end
if dimensions==1
    if strcmp(choice,'m')
       advancedlab_ising_1D_mag;
       
    else
       advancedlab_ising_1D_p;
    end
else
    if strcmp(choice,'l')
        advancedlab_ising_2D;
    else
        advancedlab_ising_2D_energymagmagsusspehea
    end
end
