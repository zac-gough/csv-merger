#!/usr/bin/env python
import pandas as pd
import PySimpleGUI as sg
import sys


def gui():

    sg.theme("Dark Teal 7")

    layout = [
        [sg.Text("Add this program to a folder with the two files you want to merge, and enter options below.")],
        [sg.Text("Note: include the .csv file extension in the file name fields below.")],
        [sg.Text("File 1:"), sg.InputText()],
        [sg.Text("File 2:"), sg.InputText()],
        [sg.Text("File 1 match column name:"), sg.InputText()],
        [sg.Text("File 2 match column name:"), sg.InputText()],
        [sg.Text("Then just press 'merge now' :)")], 
        [sg.Submit('Merge now'), sg.Cancel('Cancel')]
    ]

    window = sg.Window("CSV merger", layout)
    window_output, values = window.read()

    if window_output == ('Merge now'):
        join_files(values)
        window.close()


def join_files(values):

    file1 = values[0]
    file2 = values[1]
    column1 = values[2]
    column2 = values[3]

    df1 = pd.read_csv(file1)
    df2 = pd.read_csv(file2)

    df1 = df1[df1[column1] != None]

    merged_df = pd.merge(df1, df2, how='inner', left_on=column1, right_on=column2)

    merged_df.to_csv('output_merged.csv', index=False)

gui()