<h1>Setting up a simple File Integrity Monitor (FIM) Using PowerShell </h1>


<h2>Description</h2>
This project is a custom-built File Integrity Monitor (FIM) created using PowerShell, designed to track file changes in real-time. File integrity is a critical aspect of maintaining the security and reliability of systems, as unauthorized changes to files can indicate security breaches, corruption, or other unwanted modifications.

The FIM works by creating a baseline of file hashes using the SHA-512 algorithm and storing them in a dictionary. It continuously monitors a designated folder for new, changed, or deleted files by comparing current file hashes to the baseline. The script notifies the user if any file is added, modified, or removed, making it a powerful tool for monitoring file integrity in a lab or small-scale environment.<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 
- <b>VirtualBox</b>
- <b>Winget</b>
- <b>SHA-512 Algorithm</b>

<h2>Environments Used </h2>

- <b>Windows 2019 Server</b> 

<h2>Program walk-through:</h2>
<h3>Planning the File Integrity Monitor</h3>
To ensure that the PowerShell-based File Integrity Monitor (FIM) works effectively, I designed a workflow diagram to visualize the process. The diagram highlights the steps involved in both creating a new baseline and continuously monitoring files against that baseline. Here's a breakdown of the workflow:
<br/> <br/><img src="https://i.imgur.com/uL5uMVE.png" height="40%" width="40%" alt="Workflow Diagram"/> </br>

<b>1) Initial User Prompt</b>
- When the FIM script starts, it will ask the user if they want to either:
  - <b>Option A: </b>Collect a new baseline
  - <b>Option B: </b>Begin monitoring files using existing baseline.

<b>2) Collecting a new baseline (Option A):</b>
  - <b>Step 1: </b>The script calculates the HASH values for each target file. This is the core of file integrity monitoring, as any change in a file will result in a different hash.
  - <b>Step 2: </b>The file paths and their corresponding hash values are stored in a baseline.txt file. This file will act as the reference for future integrity checks.

<b>3) Monitoring files with saved baseline (Option B):</b>
  - <b>Step 1: </b>The script loads the file-hash pairs from the baseline.txt file.

<b>4) Continuous File Integrity Monitoring:</b>
  - <b>Step 1: </b>The script enters a loop where it continuously calculates the hash for each target file and compares it with the baseline hash stored in baseline.txt.
  - <b>Step 2: </b>If a file’s hash differs from the baseline or if a file has been deleted, the script will immediately notify the user. This notification will include color-coded output, highlighting files with integrity issues.

<b>5) Notification of File Changes:</b>
- If a file's actual hash is different from what is recorded in the baseline or if a file has been deleted, the script will print this information on the screen, clearly indicating a potential integrity compromise.

<h3>Installing PowerShell via Winget</h3>
To get started with the project, I began by ensuring I had the latest version of PowerShell installed. PowerShell comes pre-installed on most Windows systems, but it’s a good idea to use the latest version for enhanced features and security.

<b>Installation Process</b>
- Begin by launching the Command Prompt (CMD) with administrative privileges, this is important because installing or updating PowerShell requires elevated permissions.
- Use Winget to install PowerShell, Winget is a powerful tool for managing software packages on Windows, making the installation process straightforward.
<br/> <br/><img src="https://i.imgur.com/fBGQ6RK.png" height="60%" width="60%" alt="Winget"/> </br>

<h3>User Interaction Setup</h3>
In this step, I've began creating the initial user prompt for the File Integrity Monitor (FIM) script. This is where the script asks the user whether they want to collect a new baseline or start monitoring files with an existing baseline. The code snippet can be seen below.
<br/> <br/><img src="https://i.imgur.com/PUiH66W.png" height="60%" width="60%" alt="User Interaction code"/> </br>

<b>Explanation</b>
- Write-Host: This command is used to display messages on the console. In this case, it's being used to present the user with two options: "A" for collecting a new baseline and "B" for beginning to monitor files with a saved baseline.
- Read-Host: This command prompts the user for input. Here, it asks the user to enter either 'A' or 'B'. The response is then stored in the $response variable.
- Write-Host (again): The script then echoes back the user’s input for confirmation by displaying it with the message, "User entered $($response)"

<h3>Implementing Conditional Logic</h3>
After setting up the initial user prompt, the next step involves implementing conditional logic to handle the user's choice. The PowerShell script snippet below is designed to determine the next steps based on whether the user chooses to collect a new baseline or to begin monitoring files using an existing baseline.
<br/> <br/><img src="https://i.imgur.com/y6XcZV2.png" height="40%" width="40%" alt="Conditional logic"/> </br>

<b>Explanation</b>
1) if ($response -eq "A".ToUpper()):
- This line checks if the user's input (stored in $response) is equal to "A", converted to uppercase.
- If the condition is true, the script will execute the block of code that follows, which in this case includes a placeholder command to calculate hashes and create a new baseline.txt file.
2) elseif ($response -eq "B".ToUpper()):
- If the user's input is not "A", the script checks if it is "B", again comparing with an uppercase version.
- If the user chooses "B", the script will execute the code to read the existing baseline.txt file and begin monitoring the files accordingly.
3) Placeholder Commands:
- The Write-Host commands inside each conditional block serve as placeholders for now. They output messages indicating the action that would be performed based on the user’s choice.

<b>Testing the Script: </b>
By running this script, I was able to confirm that the correct paths are followed depending on whether "A" or "B" is entered. This ensures that the logic directing the script's flow is functioning as intended.

<h3>Implementing File Hash Calculation</h3>
The next step in developing the File Integrity Monitor (FIM) involves creating a function that calculates the hash of a given file. This hash will be used to detect any changes to the file over time, ensuring that its integrity is maintained.
Here's the PowerShell function I wrote to calculate file hashes
<br/> <br/><img src="https://i.imgur.com/FyPiYuX.png" height="60%" width="60%" alt="File Hash calculation function"/> </br>
<b></b>Creating Files for Monitoring:</b>
To effectively test and use this function, I created a few text files that will be monitored. These files serve as targets for the FIM to detect any changes. By calculating and storing their initial hashes, I establish a baseline against which future checks can be compared.

<h3>Saving baseline.txt</h3>
<b>Creating the Baseline</b> </br>
The next phase will involve extending the script to calculate hashes for all target files and storing them in the baseline.txt file. This will create the reference point needed for future integrity checks. To do this, I used the Get-ChildItem cmdlet to gather all the files in the folder I’m monitoring — this was the fim folder I set up on my Desktop. With the folder's contents in hand, the script then loops through each file, calculating its SHA-512 hash using my custom function.
Here’s the snippet of how I integrated this into the script:
<br/> <br/><img src="https://i.imgur.com/HmFfjk0.png" height="60%" width="60%" alt="Get-ChildItem cmdlet"/> </br>
With this set up, I can easily compute and log the hash of each file in the folder. The next step is to take these hash values and store them in baseline.txt, creating a solid baseline for the FIM to reference during monitoring.
Testing this part of the script was straightforward — I placed a few test files in the fim folder and ran the script. It correctly processed each file, generating a SHA-512 hash, which I’ll be using to monitor for changes. This laid the groundwork for the next step, where I'll focus on storing these hashes and setting up the monitoring logic. </br> </br>
I then updated the script to process each file’s hash and format it as Path|Hash. I then append this output directly to baseline.txt using | Out-File -FilePath .\baseline.txt -Append. This change improves efficiency by writing each entry to the file in each iteration, making sure the hash data is saved in a more streamlined and organized manner.
<br/> <br/><img src="https://i.imgur.com/AbZ43w1.png" height="60%" width="60%" alt="Saving baseline snippet"/> </br>
Running the script now generates baseline.txt with the hashes of the files. Each entry in the file is formatted as Path|Hash, with all file hashes appended directly to baseline.txt. This ensures that the file contains a clear and organized record of the hashes for all files processed.
<br/> <br/><img src="https://i.imgur.com/JXVYbum.png" height="60%" width="60%" alt="Baseline.txt saved"/> 

<b>Erasing the Baseline</b> </br>
I found that if I ran the script twice and selected to create a new baseline, the original baseline would still be in the file. So, to ensure the baseline stays fresh and relevant, I created the Erase-Baseline function. This function checks if a baseline.txt file already exists, and if it does, it deletes the file’s contents before saving the new hashes. This step is critical for preventing the mix-up of old and new hash data. Each time the script is run, a new baseline is generated, keeping the file integrity process clean and organized.
<br/> <br/><img src="https://i.imgur.com/DWBaRrP.png" height="60%" width="60%" alt="Erase baseline function"/> </br>

<h3>Storing hashes in a dictionary</h3>
I decided that using a dictionary would be the most efficient way to store the file paths and their corresponding hashes for my File Integrity Monitor. Allowing for fast lookups and comparisons when monitoring files against the baseline. To start, I initialized an empty dictionary ($fileHashDictionary) to hold the data. The next step was to load the file|hash pairs from baseline.txt. I used Get-Content to read the baseline file, which gave me a collection of lines, each containing a file path and its corresponding hash, separated by a pipe (|).
</br>
I then looped through each line in the file, splitting it into two parts: the file path and the hash. Using the split command, I grabbed the file path as the first part ([0]) and the hash as the second part ([1]). With both of these in hand, I added them into the dictionary as key-value pairs. The snippet can be seen below.
<br/> <br/><img src="https://i.imgur.com/i7WyqN2.png" height="60%" width="60%" alt="Storing hashes in dictionary snippet"/> </br>
Then, I decided to refine the way I loaded file paths and hashes from baseline.txt into the dictionary. Instead of manually assigning each value after splitting the string, I streamlined the process by directly adding the file path and hash as key-value pairs within the loop. This cleaned up the code and made it more efficient.
<br/> <br/><img src="https://i.imgur.com/5LLhboU.png" height="60%" width="60%" alt="Storing hashes in dictionary refined snippet"/> </br>
I ran this version of the script, and it successfully saved the file paths and their corresponding hashes into the $fileHashDictionary. When I checked the contents by simply running $fileHashDictionary, it showed all the paths and hashes neatly stored in the dictionary.
This setup is exactly how I'll handle the file monitoring, by comparing their current hashes to the ones stored in the dictionary. Having the paths and hashes organized like this makes it super easy to reference them later when I need to check for any changes.

<h3>Monitoring Files with saved Baseline</h3>
In this step, i’ll use the dictionary of stored hashes to compare the current file hashes to the baseline, detecting any changes in the process. This will be the core of your file integrity monitoring.

I went with a simple infinite loop to continuously check the files against the saved baseline. I know there are more efficient ways to handle this—like event-based monitoring with System.IO.FileSystemWatcher—but since I’m working in a home lab environment, I wanted to keep things straightforward while I build and refine the process. Plus, it's all part of the learning curve.
Here’s the basic structure I’m using for continuous monitoring:
<br/> <br/><img src="https://i.imgur.com/3R0kMPe.png" height="60%" width="60%" alt="Continuous monitoring snippet"/> </br>
The loop runs every second, simulating a basic polling mechanism that will eventually compare the current file hashes to those stored in the dictionary. While not the most resource-efficient method, it works fine for this small-scale lab setup. Besides, it’s helping me grasp the concepts of monitoring, and later on, I can look into more advanced approaches. For now, it's all about getting the monitor running and learning by doing.

<b>File Added</b> </br>
Now, I wanted to begin adding more functionality to the script, making it capable of detecting new files in the folder being monitored. The loop continuously checks for any changes by calculating the hash of each file in the folder, comparing it against the stored hashes in the dictionary.
Here's how the updated code looks:
<br/> <br/><img src="https://i.imgur.com/S7Cc4Pd.png" height="60%" width="60%" alt="File added snippet"/> </br>
I ran the program and chose the monitoring option by selecting B. As soon as I added a new file to the folder, the script immediately notified me that the file had been created. This confirmed that the detection is working as intended so far—new files in the folder are being identified.
<br/> <br/><img src="https://i.imgur.com/hxTqzyv.png" height="60%" width="60%" alt="File added snippet working"/> </br>

<b>File Altered</b> </br>
Next, I expanded the monitoring loop to not only detect new files but also alert when an existing file has been changed. By comparing the current hash of each file with the one stored in the dictionary, I can determine if the file has been modified.
The updated portion of the code can be seen below.
<br/> <br/><img src="https://i.imgur.com/0MwAsfn.png" height="60%" width="60%" alt="File altered snippet"/> </br>
After running the program and selecting B to start monitoring, I made some changes to d.txt. Right away, I was notified that the file had been altered, meaning the monitoring is functioning as expected. The script is now capable of detecting both new files and any modifications to existing ones.
<br/> <br/><img src="https://i.imgur.com/igy2Kj7.png" height="60%" width="60%" alt="File altered snippet working"/> </br>
With this set up, the file integrity monitor is now successfully tracking changes, which is a huge step forward in building out this tool in my lab environment.

<b>File Removed</b>
The final thing for me to implement is a way to detect if a file has been deleted or not. Using a loop that checks each file path stored in the dictionary, I used Test-Path to verify whether the file still exists. If it doesn’t, the script alerts me that the file has been removed.
Here’s the code I used:
<br/> <br/><img src="https://i.imgur.com/Pw6bt0f.png" height="60%" width="60%" alt="File removed snippet "/> </br>
After implementing this, I tested it by removing a file from the monitored folder. Sure enough, the program notified me immediately that the file had been deleted. Now, the monitor can handle file creations, modifications, and deletions, completing the core functionality of my File Integrity Monitor.
<br/> <br/><img src="https://i.imgur.com/Ro6yMiS.png" height="60%" width="60%" alt="File removed snippet working "/> </br>
This final feature rounds out the project, giving me full coverage over file changes in the folder I’m monitoring. The process of building this from scratch has been a great learning experience, and I’m excited to apply similar concepts in more advanced scenarios!

