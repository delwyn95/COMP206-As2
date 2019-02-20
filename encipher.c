
#include <stdio.h>
#include <stdlib.h>  // for strtol
#include <string.h>

// this code is 99.999% similar to the decipher.c
//The only difference is located in line 46 and 54
// The 'new' value is subtracted for a right shift (encipher).

char* encipher(char cipher[], int shift);   // function prototype



int main(int argc, const char * argv[]) {
    
    FILE *file1=fopen(argv[1],"r+");
    char dump, input[1000];
    
    while (! feof(file1 )) {
        fscanf (file1,"%[^\r]", input);             // reads the strings and stores in the input array.
        fscanf(file1,"%c", &dump);                  // stores spaces in the dump array.
        
    }
    
    char *shift;
    
    int conv = strtol(argv[2], shift, 10); // converts string to long integer.
    
    
    encipher(input,conv);
    
    rewind(file1); //puts the position to beginning to overwrite the data.
    fprintf(file1,"%s",input);
    fclose(file1);
    
    
    return 0;
    
}

// ======= Function ========

char* encipher(char input[], int shift) {
    int i = 0;
    
    while (input[i] != '\0') {
        if (input[i] >= 'A' && input[i]<='Z') {       //checks if the ascii value of letter is betwen A,Z (65,97)
            char newletter = input[i] - 'A' + 26;
            newletter = newletter + (26-shift); // Letter is added to the shift number.
            newletter = newletter % 26; // %26 to get the ascii value.
            input[i] = newletter + 'A'; //Add our value to get our letter.
        }
        // This elif does the same for lowercase letters.
        else if (input[i] >= 'a' && input[i] <= 'z'){  // between 97 - 122 ASCII key
            char new = input[i] - 'a' + 26 ;
            new = new + (26-shift);
            new = new % 26;
            input[i]=new + 'a';
            
        }
        
        i++;
    }
  
    
    printf("Encipher completed\n");
    return input ;
}
