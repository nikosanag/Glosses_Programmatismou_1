import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;


public class extract_from_txtfile {  
    
    public static void extraction(String filename) throws FileNotFoundException {
         try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                extractNumbers(line);
            }
            Arrange.total_nodes = build.stash.remove();
        } catch (IOException e) {
            
        }
    }
    
    private static void extractNumbers(String line) {
          try (Scanner scanner = new Scanner(line)) {
              while (scanner.hasNext()) {
                  if (scanner.hasNextInt()) {
                      int number = scanner.nextInt();
                     
                      build.stash.add(number); 
                  } else {
                      scanner.next(); // Skip non-integer token
                  }
              }
            
             
            
            }
    }

}

