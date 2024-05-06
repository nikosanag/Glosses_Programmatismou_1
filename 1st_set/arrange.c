#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

struct tree {
int number;
struct tree *left;
struct tree *right;
struct tree *behind;
bool has_left;
bool has_both;
};

struct tree* make(struct tree *previous){
struct tree *build = (struct tree*) malloc (sizeof(struct tree));
build->behind = previous;
build->left=NULL;
build->right=NULL;
build->has_left = false;
build->has_both = false;
return build;
}

void inorder(struct tree* current){
if(current!=NULL){
    inorder(current->left);

    printf("%d ",current->number);
    

    inorder(current->right);
    
     }

    
}

void smaller(struct tree* current,int *number){

        if(current!=NULL){
                if(current->number<*number) *number = current->number;
                        smaller(current->left,number);
                        smaller(current->right,number);
        }
}


void arrange(struct tree *current,int max){
if(current!=NULL){

int right = max; 
int left = max;

if(current->left!=NULL && current->right!=NULL){

        smaller(current->right,&right);
        
        smaller(current->left,&left);

      if(left>right){
          struct tree *helper;
          helper = current->left;
          current->left = current->right;
          current->right = helper;

          }
    }
else if(current->left!=NULL){
    smaller(current->left,&left);
      if(left>current->number){
          current->right = current->left;
      current->left = NULL;
          }
    }
else {
    smaller(current->right,&right);
    if(current->number>right){
        current->left = current->right;
    current->right = NULL;
        }
    }


arrange(current->left,max);
arrange(current->right,max);
}
}





int main(int argc,char *argv[]){
FILE * file;
file = fopen(argv[1],"r");

          if(file==NULL){
          perror("file not found");
          return 1;

      }


int input;
int max;

struct tree* current = make(NULL); 
struct tree* start;
start = current; 
if(fscanf(file,"%d",&input)!=EOF) max = input;
else {perror("file do not contain what it must contain"); return 1;}
if(fscanf(file,"%d",&input)!=EOF) start->number = input;
else {perror("file do not contain what it must contain"); return 1;}

int counter=0;


while(fscanf(file,"%d",&input)!=EOF){
    if(input>max|| counter>=max){ 
        printf("txt file is not correct\n");
        return 1;
    }
    
    if(input!=0){
        struct tree* new = make(current);
        	
        new->number=input;
     	
    if(current->has_left == false){
            current->has_left = true;
                    current->left = new;
                    current = new;	
        }
        else if(current->has_left == true){
                current->has_both = true;
            current->right = new; 
            current = new;
        }
        if(input!=0) counter+=1;
    }
    

    if(input==0){
        if(current->has_left==false)
            current->has_left=true;
        else if(current->has_left==true && current->has_both==false){
            current->has_both=true;
            while(current->has_both==true && current->behind !=NULL)
                            
                current=current->behind;
        }
                

        if(current->behind==NULL && current->has_both==true) break;

    
    
    
    
    
    
    }
    
    
}
fclose(file);
arrange(start,max);
inorder(start);

printf("\n");

return 0;




}