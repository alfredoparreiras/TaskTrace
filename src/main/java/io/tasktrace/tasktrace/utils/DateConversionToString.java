package io.tasktrace.tasktrace.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateConversionToString {
    public static String getFormattedDate(LocalDate date, String stringFormat)
    {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(stringFormat);
        return date.format(formatter);
    }

}
