
#include <stdio.h>
#include <stdlib.h>  // for strtol

// this code is 99.999% similar to the encipher.c
//The only difference is located in line 46 and 54
// The 'new' value is added for a left shift (decipher).

// Note: More detailed explanations in the encipher file.

char* decipher(char cipher[], int shift);



int main(int argc, const char * argv[]) {
    
    FILE *file1=fopen(argv[1],"r+");
    char dump, input[1000];
    
    while (! feof(file1)) {
        fscanf (file1,"%[^\r]", input);
        fscanf(file1,"%c", &dump);
        
    }
    
    
    
    int conv = strtoi(argv[2]);
    
    
    decipher(input,conv);
    
    rewind(file1); //puts the position to beginning to overwrite the data.
    fprintf(file1,"%s",input);
    fclose(file1);
    
    
    return 0;
    
}

// ======= Function ========

char* decipher(char input[], int shift) {
    int i = 0;
    
    while (input[i] != '\0') {
        if (input[i] >= 'A' && input[i]<='Z') {
            char newletter = input[i] - 'A' + 26;
            newletter = newletter - (26-shift);
            newletter = newletter % 26;
            input[i] = newletter + 'A';
        }
        
        else if (input[i] >= 'a' && input[i] <= 'z'){
            char new = input[i] - 'a' + 26 ;
            new = new - (26-shift);
            new = new % 26;
            input[i]=new + 'a';
            
        }
        
        i++;
    }
  
    
    printf("Decipher completed\n");
    return input ;
}
