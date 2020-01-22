/*

*/

import java.util.Random;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.IOException;

import java.net.Socket;
import java.net.ServerSocket;
import java.net.UnknownHostException;

public class GuessingGameServer 
{
    public static void main(String args[]) throws IOException
    {
        if(args.length != 2)
        {
            System.err.println("Usage: java GuessingGameServer <port number> <max guess value>");
            System.exit(1);
        }

        if(Integer.parseInt(args[0]) <= 0 || Integer.parseInt(args[1]) <= 0)
        {
            System.err.println("Error: Arguments must be greater than 0");
            System.exit(1);
        }
        int portNumber = Integer.parseInt(args[0]);

        boolean gameOn = true;
        while(gameOn)
        {
            Random rand = new Random();
            int guessValue = rand.nextInt(Integer.parseInt(args[1]));
            int guesses = 0;

            try
            {
                ServerSocket server = new ServerSocket(portNumber);
                System.out.println("The server is listening at: " + 
                    server.getInetAddress() + " on port " + 
                    server.getLocalPort());
                
                Socket client = server.accept();
                System.out.println("Connection established.");

                PrintWriter output = 
                    new PrintWriter(client.getOutputStream(), true);
                BufferedReader input = 
                    new BufferedReader(new InputStreamReader(client.getInputStream()));


                String inString = input.readLine();
                while(!inString.equals("quit"))
                {
                    //System.out.println("After next read");
                    guesses++;
                    int guess = Integer.parseInt(inString);
                    System.out.println("Self: Guess = " + guess);
                    if(guess == guessValue)
                    {
                        output.println("Server: You guessed correctly. You took " + guesses + " guesses.");
                        System.out.println("Self: Correct guess achieved.");
                        //gameOn = false;
                        break;
                    }
                    else if(guess < guessValue)
                    {
                        output.println("Server: Incorrect. Guess higher.");
                    }
                    else if(guess > guessValue)
                    {
                        output.println("Server: Incorrect. Guess lower.");
                    }
                    inString = input.readLine();
                    System.out.println(inString);
                }
                
                output.println("Server: Game complete.");
                server.close();
            }
            catch(IOException e)
            {
                System.out.println("Exception caught when trying to listen on port "
                    + portNumber + " or listening for a connection");
                System.out.println(e.getMessage());
            }
            
        }
    }
}