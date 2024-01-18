```
<select id="selectNoteCount" resultMap="AdmMainStatusInfoDAO.admMainStatusInfoVO">
		SELECT *
		FROM CROSSTAB(
			'	WITH year_month AS (
					SELECT yl, ml
					FROM (SELECT yl::varchar FROM GENERATE_SERIES(2023, 2024) AS TBL(yl)) AS t1
					, (SELECT LPAD(GENERATE_SERIES(01,13)::varchar,2,''0'') AS ml) AS t2
				)
				, sts_detail AS (
					SELECT to_char(frst_regist_dt, ''YYYY'') AS yyyy
						, to_char(frst_regist_dt, ''MM'') AS mm
						, count(*) AS cnt
					FROM (
						SELECT * FROM (
							SELECT * FROM note_info_1
							union
							SELECT * FROM note_info_2
							union
							SELECT * FROM note_info_3
							union
							SELECT * FROM note_info_4
							union
							SELECT * FROM note_info_5
							union
							SELECT * FROM note_info_6
							union
							SELECT * FROM note_info_7
						) T
					) AS T
					group by to_char(frst_regist_dt, ''YYYY''), to_char(frst_regist_dt, ''MM''), note_no
				)
				, sts_result AS (
					SELECT yyyy
						, mm
						, sum(cnt) AS total
					FROM sts_detail
					GROUP BY yyyy, mm
					UNION ALL
					SELECT yyyy
						, ''13''
						, sum(cnt) AS total
					FROM sts_detail
					GROUP BY yyyy
					ORDER BY yyyy ASc, mm ASc
				)
				SELECT yl, ml, COALESCE(total, 0) AS total
				FROM year_month
					LEFT OUTER JOIN 
					sts_result
					ON (yl = yyyy AND ml = mm)
				ORDER BY yl ASc, ml ASc	'
			  , $$
					SELECT LPAD(generate_series(01,13)::varchar,2,'0') ORDER BY 1
				$$
			) AS sts (year text,"m1" text,"m2" text,"m3" text,"m4" text,"m5" text,"m6" text,"m7" text,"m8" text,"m9" text,"m10" text,"m11" text,"m12" text,"total" text)
		
	</select>
		
)
```
