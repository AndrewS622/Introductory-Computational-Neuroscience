
%% Load AlexNet 
net = alexnet;  % Load neural net. 


%% Plot weights from the first convolution layer

% Get the network weights for the first convolutional layer
w1 = net.Layers(2).Weights;

% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5);

% Display a montage of network weights. There are 96 individual sets of
% weights in the first layer.
figure
montage(w1)
title('First convolutional layer weights')

% List all the layers in the network
net.Layers

%% Run the peppers image through AlexNet

im = imresize(imread('peppers.png'),[227 227]);
label = classify(net, im);
figure
imshow(im)
title('Classified Image');
text(10,20,char(label),'Color','white')
%%pause

%% Plot the neural activities of different filters

f = activations(net, im, 'conv1');

fil=[3,10,59];
for i = fil
    figure
    filter = i;
    subplot(131)
    imshow(w1(:,:,:,filter))
    axis square
    title(sprintf('Filter #%d',filter))

    subplot(133)
    imshow(im)
    axis square
    title('Original image')

    subplot(132)
    imagesc(f(:,:,filter))
    axis square
    title('Response')
    %%pause
end

%% Load data from Kriegeskorte, N., Mur, M., Ruff, D. A., Kiani, R., Bodurka, J., Esteky, H., ? Bandettini, P. A. (2008). Matching Categorical Object Representations in Inferior Temporal Cortex of Man and Monkey. Neuron, 60(6), 1126?1141. http://doi.org/10.1016/j.neuron.2008.10.043

load RDM_stimuli


%% Test translation invariance
clear act_corr

Tr=0:5:180;                                                                 %Tested translations
Tr=[Tr;zeros(1,37)];                                                        %Trans in x and y
im_num = 41; % German shephard image number.
im = images(:,:,:,im_num);
im2=im/255;
figure
imagesc(im2);                                                               %%Show test image
title('German Shepherd Image');
label = classify(net, im);                                                  %%Classify test image
text(150,20,char(label),'Color','white')

layers = {'data','conv1','pool1','conv5','pool5','fc7','prob'};             %Tested layers

cor=zeros(length(Tr),7);                                                    %Correlations
act=cell(length(Tr),7);                                                     %Activations in each layer for all translations
act1=cell(1,7);                                                             %Activations in each layer without translation

for i=1:7
    l=layers(i);    
    act1{i}=activations(net,im,l{1},'OutputAs','columns');                  %Obtain untranslated activations
end

s=size(im);
imtrans=zeros(s(1),s(2),s(3),length(Tr));                                   %Translated image matrix
for i=1:length(Tr)
    imtrans(:,:,:,i)=imtranslate(im,Tr(:,i));                               %Obtain given translation
    for j=1:7
        l=layers(j);
        act{i,j}=activations(net,imtrans(:,:,:,i),l{1},'OutputAs','columns');   %Activations for all layers for given translation
        cor(i,j)=corr(act{i,j},act1{j});                                    %Correlation between translated and untranslated images
    end
end
for i=1:7
                                                                            %%Plot individual correlations
    %%l=layers(i);
    %%figure
    %%plot(Tr,cor(:,i));
    %%title(l{1});
end

%% Test rotation invariance
clear act_corr

Tr2=0:5:180;                                                                %%Tested rotation angles
im_num = 41; % German shephard
im = images(:,:,:,im_num);

layers = {'data','conv1','pool1','conv5','pool5','fc7','prob'};             %%Tested layers

cor2=zeros(length(Tr2),7);                                                  %%Correlations
act2=cell(length(Tr2),7);                                                   %%Rotated activations
act12=cell(1,7);                                                            %%Unrotated activations

for i=1:7
    l=layers(i);
    act12{i}=activations(net,im,l{1},'OutputAs','columns');                 %%Get unrotated activations
end

s=size(im);
imtrans2=zeros(s(1),s(2),s(3),length(Tr2));                                 %%Rotated images
for i=1:length(Tr)
    imtrans2(:,:,:,i)=imrotate(im,Tr2(i),'crop');                           %%Get rotated image
    for j=1:7
        l=layers(j);                        
        act2{i,j}=activations(net,imtrans2(:,:,:,i),l{1},'OutputAs','columns'); %%Get rotated activations
        cor2(i,j)=corr(act2{i,j},act12{j});                                 %Calculate correlation
    end
end
for i=1:7
                                                                            %%Plot rotated layer correlations
    %%l=layers(i);
    %%figure
    %%plot(Tr,cor2(:,i));
    %%title(l{1});
end

for i=1:7
    l=layers(i);                                                            %%Plot both translated and rotated correlations to compare
    figure
    subplot(2,1,1)
    plot(Tr,cor(:,i));
    title(strcat(l{1},' translated'));
    subplot(2,1,2)
    plot(Tr,cor2(:,i));
    title(strcat(l{1},' rotated'));
end
%% Test correlation between AlexNet RDMs and neural RDMs
clear c h

layers={'data','conv1','pool1','pool2','relu3','relu4','relu5','pool5','fc6','fc7','fc8'};

r=cell(92,11);                                                              %%Activations for each layer in response to each image
p=zeros(92,92,11);                                                          %%Correlation matrix for each layer
R=p;                                                                        %%RDM matrix for each layer

for i=1:92
    for j=1:11
        l=layers(j);
        r{i,j}=activations(net,images(:,:,:,i),l{1},'OutputAs','columns');  %%Get activations for each layer and each image
    end
end

for i=1:92
    for j=1:92
        for k=1:11
            p(i,j,k)=corr(r{i,k},r{j,k});                                   %%Get correlations between each pair of images in a given layer across all layers
            R(i,j,k)=1-p(i,j,k);                                            %%Calculate RDM as 1-p
        end
    end
end

figure
lay=1;                                                                      %%Layer to compute RDM
d = R(:,:,lay); % Compute AlexNet RDM at a specific layer by extracting from above
layname = layers(lay);      
subplot(131)
imagesc(d)
title(strcat('Alex Net RDM for layer ',{' '},layname{1}));
caxis([0 1])
axis square

RDMChoice = 1;                                                              %%Choice between RDM1 and RDM2
if RDMChoice == 1
    d_data = RDM1; % Plot experimental RDM
    subplot(132)
    imagesc(d_data)
    title('RDM for Electrode Recordings');
    caxis([0 1])
    axis square
else if RDMChoice == 2
d_data = RDM2; % Plot experimental RDM
    subplot(132)
    imagesc(d_data)
    title('RDM for fMRI');
    caxis([0 1])
    axis square
    end
end
        
subplot(133) % Plot correlation
plot(d(:),d_data(:),'.')
title('Correlation between RDMs');
xlim([0 1.5])
ylim([0 1.5])
axis square

c=zeros(1,11);
for i=1:11
    lay=i;                                                                      %%Layer to compute RDM
    d = R(:,:,lay);
    c(i) = corr(d(:),d_data(:));
end
figure
plot(1:11,c);
title('Correlation Between Experimental and AlexNet RDM at Each Layer')