%{
This wrapper program asks the user for input to determine which script to run.
Based on the choice that user inputs,the specified model is displayed.
Note that if you choose to run this wrapper class, you don't need to run the
individual 1D or 2D programs separately. The results are just the same
whether you run the program using this wrapper class or as individuals. We
recommed running the wrapper class though, because it provides better
functionality and usability
%}

%prompt the user to enter the dimensions of the models
%the dimensions are either 1(for 1D model) or 2 (for 2D model) 
dimensions = input('Please enter the dimensions of the model (1 or 2):  '); 

choice='c'; %the choice that user takes

%the dimensions are between 0 and 2 but for simplicity and for the purpose of our project
%we decided to make the dimensions either 1(for 1D model) or 2 (for 2D model)
%in this case depend. If user enters a number less than 0 or greater than 2, an error is displayed 
%and the user is prompted to enter the correct dimensions again
while dimensions<1||dimensions>2
    dimensions=input('Invalid dimensions. \nPlease enter the dimensions of the model (1 or 2):  ');
end

%allows the user to enter the choices for what model to run. The models are
%either latice or magnetization. Again for simplicity, if the user choses
%'l' for latices, the latices model is run/displayed. If the user chooses 'm'
%for magnetization, the magnetization is run/displayed
choice=input('Choose the model ((l)atices or (m)agnetization): ','s');
while ~strcmp(choice,'l')&&~strcmp(choice,'m')
    choice=input('Invalid model choice. \nChoose the model ((l)atices or (m)agnetization): ','s');
end

%takes care of the choices that the user takes and displays the specified
%model
if dimensions==1 %dimensions of 1 runs the 1-D models
    if strcmp(choice,'l') %if the user chooses 'l', the 1D lattice model is displayed
        ising_1D_lat;    
    %otherwise the 1D magnetization model is displayed
    else
     ising_1D_mag;
    end
%this part of the statement runs the 2D model
else
    if strcmp(choice,'l') %if the user chooses 'l' for lattice, the 2D lattice model is displayed
        ising_2D_lat;
    else %otherwise the 2D magnetization  model is displayed
        ising_2D_mag;
    end
end
